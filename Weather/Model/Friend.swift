//
//  Friend.swift
//  Weather
//
//  Created by Сергей Родионов on 20.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import Foundation
import UIKit

class Friend {
    var friendName: String
    var friendImage: UIImage
    
    init(friendName: String, friendImage: UIImage) {
        self.friendName = friendName
        self.friendImage = friendImage
    }
}
