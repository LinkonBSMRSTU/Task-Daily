//
//  TaskTableViewCell.swift
//  Task-Daily
//
//  Created by Fazle Rabbi Linkon on 10/2/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
