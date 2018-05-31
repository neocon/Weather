//
//  AllGroupListViewCell.swift
//  Weather
//
//  Created by Сергей Родионов on 21.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class AllGroupListViewCell: UITableViewCell {
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var imageContainer: UIImageView!
    
    func configure(group: Group){
        populationLabel.text = String(group.groupPopulation)
        groupName.text = group.groupName
        
        if let iconURL = URL(string: group.groupImage) {
            imageContainer.kf.setImage(with: iconURL)
        }
    }
}
