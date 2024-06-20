//
//  GamesResponse.swift
//  Assignment365Scores
//
//  Created by Hameed Dahabry on 18/06/2024.
//

import Foundation

struct GamesResponse: Codable {
    let games: [Game]
    let competitions: [Competition]
}

//The only relevant fields for parsing are “Games” and “Competitions”.
