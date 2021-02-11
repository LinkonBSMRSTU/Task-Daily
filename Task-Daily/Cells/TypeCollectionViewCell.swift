//
//  TypeCollectionViewCell.swift
//  Task-Daily
//
//  Created by Fazle Rabbi Linkon on 10/2/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import UIKit

class TypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var taskType: UILabel!
    @IBOutlet weak var taskCount: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var backView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.bgView.dropShadow(color: .black, opacity: 0.5, offSet: CGSize(width: 1, height: 1), radius: 10, scale: true)
    }

}
