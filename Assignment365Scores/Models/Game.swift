//
//  Game.swift
//  Assignment365Scores
//
//  Created by Hameed Dahabry on 18/06/2024.
//

import Foundation

struct Game: Codable {
    let id: Int
    let stid: Int
    let sTime: String
    let active: Bool
    let gt: Double
    let comp: Int
    let comps: [Competitor]
    let scrs: [Int]
    
// I used custom decoding strategy using pascal case decoding
//    enum CodingKeys: String, CodingKey {
//        case id = "ID"
//        case sid = "SID"
//        case sTime = "STime"
//        case active = "Active"
//        case gt = "GT"
//        case comps = "Comps"
//        case scrs = "Scrs"
//    }
}

//The only relevant fields are: “ID”, “STID”, “STime”, “Comp”, “Active”, GT”,
//“Comps” and “Scrs”.
