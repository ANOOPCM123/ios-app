//
// Copyright © 2023 Singleton Commerce.
//
// All rights reserved.
//
// This software is the confidential and proprietary information of Singleton Commerce ("Confidential Information"). You
// shall not disclose such Confidential Information and shall use it only in accordance with the terms of the contract
// agreement you entered into with Singleton Commerce.

// @author Jinto Joseph
//
import Foundation
/// Load json file from Bundle
public func loadFromBundle<T: Decodable>(_ filename: String, as type: T.Type = T.self) throws -> T {
    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: "json") else {
        throw ParsingError.fileNotFound
    }
    do {
        data = try Data(contentsOf: file)
        return try parse(data, as: T.self)
    } catch {
        throw ParsingError.unableToLoadFile
    }
}
/// Load json file from URL path
public func loadFromURL<T: Decodable>(_ url: URL, as type: T.Type = T.self) throws -> T {
    do {
        let contents = try String(contentsOf: url)
        return try parse(contents.data(using: .utf8)!, as: T.self)
    } catch {
        throw ParsingError.unableToLoadFile
    }
}
/// Parse JSON  from Data format
public func parse<T: Decodable>(_ data: Data, as type: T.Type = T.self) throws -> T {
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print(error)
        throw ParsingError.unableToParseData
    }
}
/// PARSING ERROR CUSTOM MESSAGES
enum ParsingError: Error {
    case unableToParseData
    case unableToLoadFile
    case fileNotFound
}
extension ParsingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unableToLoadFile:
            return "Unable to load file"
        case .fileNotFound:
            return "Unable to find file or folder"
        case .unableToParseData:
            return "Unable to parse data. Please check JSON data"
        }
    }
}
