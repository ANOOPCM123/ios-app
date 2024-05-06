import Foundation
import Apollo
import Combine
import ApolloAPI

enum NetworkError: Error {
    case noData
    case decodingError(Error)
    case invalidStatusCode(Int)
    case networkUnavailable
    case unauthorized
    case graphQLRequestError(Error)
    case tokenRefreshError(Error)
}

struct RESTRequest<T: Encodable>: Encodable {
    let url: URL
    let method: String
    let body: T?
    var headers: [String: String]?
    
    init(url: URL, method: String = "GET", body: T? = nil, headers: [String: String]? = nil) {
        self.url = url
        self.method = method
        self.body = body
        self.headers = headers
    }
}

protocol NetworkService {
    func executeGraphQLQuery<T: GraphQLQuery>(query: T) -> AnyPublisher<T.Data, NetworkError>
    func executeGraphQLMutation<T: GraphQLMutation>(mutation: T) -> AnyPublisher<T.Data, NetworkError>
    func performRESTRequest<T: Decodable>(request: RESTRequest<T>) -> AnyPublisher<T, NetworkError>
}

class NetworkServiceImpl: NetworkService {
    private let apolloClient: ApolloClient
    private let authService: AuthService // Assume you have an AuthService for managing tokens
        
    init(apolloClient: ApolloClient, authService: AuthService = AuthServiceImpl()) {
        self.apolloClient = apolloClient
        self.authService = authService
    }
    
    // GraphQL query
     func executeGraphQLQuery<T: GraphQLQuery>(query: T) -> AnyPublisher<T.Data, NetworkError> {
       return Future { promise in
         self.apolloClient.fetch(query: query) { result in
           switch result {
           case .success(let graphQLResult):
             if let data = graphQLResult.data {
               promise(.success(data))
             } else if let errors = graphQLResult.errors {
               let errorDescription = errors.map { $0.localizedDescription }.joined(separator: "\n")
               let customError = NSError(domain: "GraphQL", code: 0, userInfo: [NSLocalizedDescriptionKey: errorDescription])
               promise(.failure(NetworkError.decodingError(customError)))
             } else {
               promise(.failure(NetworkError.noData))
             }
           case .failure(let error):
               if let responseError = error as? HTTPURLResponse, responseError.statusCode == 401 {
                   // Token expired, attempt refresh
                   self.refreshGraphQLTokenAndRetry(query: query, promise: promise)
               } else {
                   // Other network or decoding errors
                   promise(.failure(NetworkError.decodingError(error)))
               }
           }
         }
       }
       .eraseToAnyPublisher()
     }

    private func refreshGraphQLTokenAndRetry<T: GraphQLQuery>(
        query: T,
        promise: @escaping (Swift.Result<T.Data, NetworkError>) -> Void // Specify Swift.Result here
    ) {
        authService.refreshToken()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    // Handle token refresh failure (e.g., show an error message)
                    print("Token refresh failed: \(error)")
                    promise(.failure(NetworkError.tokenRefreshError(error)))
                }
            }, receiveValue: { [weak self] newTokens in
                // Retry the query with the updated token
                self?.executeGraphQLQuery(query: query)
                    .sink(receiveCompletion: { completion in
                        // Propagate completion to the original promise
                        if case .failure(let error) = completion {
                            promise(.failure(error))
                        }
                    }, receiveValue: { data in
                        // Propagate data to the original promise
                        promise(.success(data))
                    })
            })
    }

    // GraphQL mutation (similar approach to query)
    func executeGraphQLMutation<T: GraphQLMutation>(mutation: T) -> AnyPublisher<T.Data, NetworkError> {
        return Future { promise in
            self.apolloClient.perform(mutation: mutation) { result in
                switch result {
                case .success(let graphQLResult):
                    if let data = graphQLResult.data {
                        promise(.success(data))
                    } else if let errors = graphQLResult.errors {
                        let errorDescription = errors.map { $0.localizedDescription }.joined(separator: "\n")
                        let customError = NSError(domain: "GraphQL", code: 0, userInfo: [NSLocalizedDescriptionKey: errorDescription])
                        promise(.failure(NetworkError.decodingError(customError)))
                    } else {
                        promise(.failure(NetworkError.noData))
                    }
                case .failure(let error):
                    if let responseError = error as? HTTPURLResponse, responseError.statusCode == 401 {
                        // Token expired, attempt refresh
                        //self.refreshGraphQLTokenAndRetry(query: query, promise: promise)
                    } else {
                        // Other network or decoding errors
                        promise(.failure(NetworkError.decodingError(error)))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    // REST request
    func performRESTRequest<T: Decodable>(request: RESTRequest<T>) -> AnyPublisher<T, NetworkError> {
        URLSession.shared.dataTaskPublisher(for: request.url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.noData
                }
                switch httpResponse.statusCode {
                case 200..<300:
                    return data
                case 401:
                    throw NetworkError.unauthorized
                default:
                    throw NetworkError.invalidStatusCode(httpResponse.statusCode)
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.decodingError(error)
            }
            .flatMap { decodedData -> AnyPublisher<T, NetworkError> in
                Just(decodedData)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
            }
            .handleEvents(receiveCompletion: { completion in
                if case .failure(NetworkError.unauthorized) = completion {
                    // Token expired, attempt refresh
                    self.refreshTokenAndRetry(request: request)
                }
            })
            .eraseToAnyPublisher()
    }
    
    
    private func refreshTokenAndRetry<T: Decodable>(request: RESTRequest<T>) {
            authService.refreshToken()
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        // Handle token refresh failure (e.g., show an error message)
                        print("Token refresh failed: \(error)")
                    }
                }, receiveValue: { [weak self] newTokens in
                    // Update request headers with the new access token
                    var updatedRequest = request
                    updatedRequest.headers?["Authorization"] = "Bearer \(newTokens.accessToken)"
                    
                    // Retry the request with the updated token
                    self?.performRESTRequest(request: updatedRequest)
                        .sink(receiveCompletion: { _ in }, receiveValue: { _ in
                            // Request succeeded with the updated token
                        })
                })
        }
}


protocol AuthService {
    func refreshToken() -> AnyPublisher<AuthTokens, AuthError>
}

struct AuthTokens {
    var accessToken: String
    var refreshToken: String
}

enum AuthError: Error {
    case tokenRefreshFailed
}

class AuthServiceImpl: AuthService {
    private var tokens: AuthTokens? // Assume you have a property to store tokens
    func refreshToken() -> AnyPublisher<AuthTokens, AuthError> {
        guard let refreshToken = tokens?.refreshToken else {
            return Fail(error: AuthError.tokenRefreshFailed).eraseToAnyPublisher()
        }
        // Simulate token refresh logic (e.g., API call to refresh endpoint)
        // Replace with actual token refresh logic
        // For demonstration purposes, we'll assume a successful refresh here
        let newAccessToken = "new-access-token"
        tokens?.accessToken = newAccessToken

        // Return the updated tokens
        return Just(tokens!)
            .setFailureType(to: AuthError.self)
            .eraseToAnyPublisher()
    }
}
