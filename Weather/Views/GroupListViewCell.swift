//
//  GroupListViewCell.swift
//  Weather
//
//  Created by Сергей Родионов on 21.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import UIKit
import Kingfisher

class GroupListViewCell: UITableViewCell {
    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    func configure(group: Group){
        groupNameLabel.text = group.groupName
        
        if let iconURL = URL(string: group.groupImage) {
            imageContainer.kf.setImage(with: iconURL)
        }
    }
}
