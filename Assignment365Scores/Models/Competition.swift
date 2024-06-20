//
//  Competition.swift
//  Assignment365Scores
//
//  Created by Hameed Dahabry on 18/06/2024.
//

import Foundation

struct Competition: Codable, Hashable {
    let id: Int
    let name: String

// I used custom decoding strategy using pascal case decoding
//    enum CodingKeys: String, CodingKey {
//        case id = "ID"
//        case name = "Name"
//    }
}
