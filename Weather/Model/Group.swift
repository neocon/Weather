//
//  Group.swift
//  Weather
//
//  Created by Сергей Родионов on 21.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import RealmSwift

class Group: Object{
    @objc dynamic var groupId: UInt = 0
    @objc dynamic var groupName:String = ""
    @objc dynamic var groupImage: String = ""
    @objc dynamic var groupPopulation: UInt = 0
    
    convenience init(json: JSON){
        self.init()
        
        self.groupId = json["id"].uIntValue
        self.groupName = json["name"].stringValue
        self.groupPopulation = json["members_count"].uIntValue
        self.groupImage = json["photo_100"].stringValue
    }
}
