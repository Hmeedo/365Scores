//
//  GameDateFormmatter.swift
//  Assignment365Scores
//
//  Created by Hameed Dahabry on 20/06/2024.
//

import Foundation

class GameDateFormatter {
    private let inputDateFormatter : DateFormatter
    
    init() {
        // the input format is 'dd-MM-yyyy HH:mm'
        inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        
    }
    
    func startGameDate(of game: Game) -> String? {
        guard let date = inputDateFormatter.date(from: game.sTime) else {
            return nil
        }
        // the output format is 'dd-MM-yyyy hh:mm'
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd-MM-yyyy"
        return outputDateFormatter.string(from: date)
    }
    
    func startGameTime(of game: Game) -> String? {
        guard let date = inputDateFormatter.date(from: game.sTime) else {
            return nil
        }
        // the output format is 'hh:mm'
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "HH:mm"
        return outputDateFormatter.string(from: date)
    }
}
