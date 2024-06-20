//
//  Assignment365ScoresTests.swift
//  Assignment365ScoresTests
//
//  Created by Hameed Dahabry on 18/06/2024.
//

import XCTest
@testable import Assignment365Scores

final class Assignment365ScoresTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParsingGames() throws {
        let apiService = APIServiceMock()
        let gameService = GamesService(apiService: apiService)
        Task {
            let response = try await gameService.fetchGames()
            XCTAssertNotNil(response)
        }
    }



}
