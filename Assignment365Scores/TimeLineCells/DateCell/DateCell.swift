//
//  DateTimeLineCell.swift
//  Assignment365Scores
//
//  Created by Hameed Dahabry on 20/06/2024.
//

import UIKit

protocol TimeLineObjectView {
    func configure(with object: TimeLineObject)
}

class DateCell: UITableViewCell, TimeLineObjectView {
    @IBOutlet weak var label: UILabel!
    
    func configure(with object: TimeLineObject) {
        label.text = object.date ?? ""
    }
}
