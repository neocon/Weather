//
//  Friend.swift
//  Weather
//
//  Created by Сергей Родионов on 20.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import Foundation
import SwiftyJSON

class Friend {
    var friendId: UInt
    var friendName: String
    var friendImage: String
    
    init(friendName: String, friendImage: String) {
        self.friendName = friendName
        self.friendImage = friendImage
        self.friendId = 0
    }
    
    init(json: JSON){
        friendId = json["id"].uIntValue
        friendName = json["first_name"].stringValue + " " + json["last_name"].stringValue
        friendImage = json["photo_100"].stringValue
    }
}
