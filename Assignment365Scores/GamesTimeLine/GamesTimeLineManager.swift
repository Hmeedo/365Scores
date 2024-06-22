//
//  GamesTimeLineManager.swift
//  Assignment365Scores
//
//  Created by Hameed Dahabry on 20/06/2024.
//

import Foundation

protocol TimeLineManagerProtocol {
    func fetchTimeLine() async throws -> [TimeLineObject]
}

class GamesTimeLineManager: TimeLineManagerProtocol {
    private let gamesService: GamesServiceProtocol
    
    init(gamesService: GamesServiceProtocol) {
        self.gamesService = gamesService
    }
    
    func fetchTimeLine() async throws -> [TimeLineObject] {
        let gamesResponse = try await gamesService.fetchGames()
        // lets convert games response to TimeLine
        // the output timeline will be [date1, COMP1, game1, game2, COMP2, game3, date2, COMP3, game4, .......]
         
        // first lets prepare competitions so can be accessed via key,value with o(1)
         var competitions = [Int: Competition]()
         for competition in gamesResponse.competitions {
             competitions[competition.id] = competition
         }
         // we should split games by day
         var gamesByDay = [String : [Game]]()
         
         //create formatter that will convert STime to day
         let gameDateFormatter = GameDateFormatter()
         for game in gamesResponse.games {
             if let gameStartDay = gameDateFormatter.startGameDate(of: game) {
                 //check if date does not exist if it does not then add one
                 if gamesByDay[gameStartDay] == nil {
                     gamesByDay[gameStartDay] = []
                 }
                 // add game to its corresponding date
                 gamesByDay[gameStartDay]!.append(game)
             }else {
                 print("adding game \(game.id) failed of invalid game start time (STime)")
             }
         }
         
        //now data is prepared its time to return the time line
        return populateTimeLine(gamesByDay: gamesByDay, competitions: competitions)
    }
    
    
    private func populateTimeLine(gamesByDay: [String : [Game]], competitions: [Int : Competition]) -> [TimeLineObject] {
        var timeLine = [TimeLineObject]()
        // sort days by smallest
        let days = gamesByDay.keys.sorted()
        // will maybe not the best way need more time to look more efficient way for enumeration data
        for day in days {
            // get games for specific day
            guard let games = gamesByDay[day] else {
                continue
            }
            // add day as timeline object
            timeLine.append(TimeLineObject(data: day, type: .date))
            // sort games by competition
            let sortedGames = games.sorted(by: {$0.comp < $1.comp})
            //the idea is to add comp and then its games, when game.comp changes we add the next comp and so on
            var lastGameComp : Int?
            for game in sortedGames {
                guard let competition = competitions[game.comp] else {
                    print("no competition with id\(game.comp) was found, game \(game.id) will not be added to timeline")
                    continue
                }
                // if its first game or game comp changed then add competition and its games
                if lastGameComp == nil || lastGameComp != game.comp {
                    lastGameComp = game.comp
                    timeLine.append(TimeLineObject(data: competition, type: .competition))
                }
                timeLine.append(TimeLineObject(data: game, type: .game))
            }
        }
        return timeLine
    }
}

struct TimeLineObject {
    var data: Any
    var type: TimeLineObjectType
    
    var date: String? {
        guard type == .date else { return nil }
        return data as? String
    }
    
    var game: Game? {
        guard type == .game else { return nil }
        return data as? Game
    }
    
    var competition: Competition? {
        guard type == .competition else { return nil }
        return data as? Competition
    }
}

enum TimeLineObjectType: String {
    case game
    case competition
    case date
}
