//
//  GameCell.swift
//  Assignment365Scores
//
//  Created by Hameed Dahabry on 20/06/2024.
//

import UIKit

class GameCell: UITableViewCell,TimeLineObjectView {
    @IBOutlet weak var teamName1: UILabel!
    @IBOutlet weak var teamName2: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func configure(with object: TimeLineObject) {
        teamName1.text = ""
        teamName2.text = ""
        timeLabel.text = ""
        statusLabel.text = ""
        
        guard let game = object.game else {
          return
        }
        
        teamName1.text = game.comps.first?.name ?? ""
        teamName2.text = game.comps.last?.name ?? ""
        
        if game.stid == 2 {
            // the game has not been started yet
            let gameDateFormatter = GameDateFormatter()
            timeLabel.isHidden = true
            statusLabel.text = gameDateFormatter.startGameTime(of: game)
        }else if game.active == true {
            // the game is live show score and time
            timeLabel.isHidden = false
            timeLabel.text = String(format: "%02d'", Int(game.gt))
            statusLabel.text = game.score
            
        }else if game.stid == 3 {
            // the game is finished show only score
            timeLabel.isHidden = true
            statusLabel.text = game.score
        }
        layoutIfNeeded()
    }
}

extension Game {
    var score: String {
        if scrs.count == 0 {
            return "0 - 0"
        }else if scrs.count == 1 {
            return "\(scrs[0]) - 0"
        }else {
            return  "\(scrs[0]) - \(scrs[1])"
        }
    }
}
