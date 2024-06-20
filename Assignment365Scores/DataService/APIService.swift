//
//  APIService.swift
//  Assignment365Scores
//
//  Created by Hameed Dahabry on 20/06/2024.
//

import Foundation

protocol APIServiceProtocol {
    func getGamesData() async throws -> Data
}

class APIServiceMock: APIServiceProtocol {
    func getGamesData() async throws -> Data {
        guard let url = Bundle.main.url(forResource: "mock_data", withExtension: "json") else {
            throw APIService.APIError.invalidURL
        }
        return try Data(contentsOf: url)
    }
}

class APIService: APIServiceProtocol {
    func getGamesData() async throws -> Data {
        let url = URL(string: "http://demo2170822.mockable.io/assignment")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

extension APIService {
    enum APIError: Error {
        case invalidURL
    }
}
