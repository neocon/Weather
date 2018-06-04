//
//  Friend.swift
//  Weather
//
//  Created by Сергей Родионов on 20.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Friend: Object {
    @objc dynamic var friendId: UInt = 0
    @objc dynamic var friendName: String = ""
    @objc dynamic var friendImage: String = ""
    
    convenience init(json: JSON){
        self.init()
        
        self.friendId = json["id"].uIntValue
        self.friendName = json["first_name"].stringValue + " " + json["last_name"].stringValue
        self.friendImage = json["photo_100"].stringValue
    }
}
