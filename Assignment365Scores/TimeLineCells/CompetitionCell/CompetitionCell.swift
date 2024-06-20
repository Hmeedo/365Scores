//
//  CompetitionCell.swift
//  Assignment365Scores
//
//  Created by Hameed Dahabry on 20/06/2024.
//

import UIKit

class CompetitionCell: UITableViewCell, TimeLineObjectView {
    @IBOutlet weak var label: UILabel!
    
    func configure(with object: TimeLineObject) {
        label.text = ""
        guard let competition = object.competition else {
          return
        }
        label.text = competition.name
    }
}
