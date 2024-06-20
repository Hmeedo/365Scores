//
//  GamesService.swift
//  Assignment365Scores
//
//  Created by Hameed Dahabry on 18/06/2024.
//

import Foundation

protocol GamesServiceProtocol {
    func fetchGames() async throws -> GamesResponse
}

class GamesService: GamesServiceProtocol {
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchGames() async throws -> GamesResponse {
        let jsonData = try await apiService.getGamesData()
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromPascalCase
        return try decoder.decode(GamesResponse.self, from: jsonData)
    }
}

extension JSONDecoder.KeyDecodingStrategy {
    static var convertFromPascalCase: JSONDecoder.KeyDecodingStrategy {
        return .custom { keys -> CodingKey in
            // the keys array is never empty
            let key = keys.last!
            // Do not change the key for an array
            guard key.intValue == nil else {
                return key
            }

            let codingKeyType = type(of: key)
            
            //we need to check if all letters are uppercased then we treat it like its one word and lower the case
            //e.g ID, STID, SID, GT must be converted to id, stid, sid ,gt
            if key.stringValue.uppercased() == key.stringValue {
                return codingKeyType.init(stringValue: key.stringValue.lowercased())!
            }else {
                // for all other Pascal Case keys must be converted to Lower Camel Case
                //eg StatusSequence must be converted to statusSequence
                return codingKeyType.init(stringValue: key.stringValue.firstCharLowercased())!
            }
        }
    }
}

private extension String {
    func firstCharLowercased() -> String {
        prefix(1).lowercased() + dropFirst()
    }
}
