//
//  FriendListViewCell.swift
//  Weather
//
//  Created by Сергей Родионов on 20.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import UIKit
import Kingfisher

class FriendListViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageContainer: UIImageView!
    
    var friendId: UInt = 0
    
    func configure(friend: Friend){
        titleLabel.text = friend.friendName
        
        friendId = friend.friendId
        
        if let iconURL = URL(string: friend.friendImage) {
            imageContainer.kf.setImage(with: iconURL)
        }
    }
}
