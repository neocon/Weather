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

class Group{
    var groupId: UInt
    var groupName:String
    var groupImage: String
    var groupPopulation: UInt
    
    init(groupName: String, groupImage: String, groupPopulation: UInt) {
        self.groupImage = groupImage
        self.groupName = groupName
        self.groupPopulation = groupPopulation
        self.groupId = 0
    }
    
    init(json: JSON){
        groupId = json["id"].uIntValue
        groupName = json["name"].stringValue
        groupPopulation = json["members_count"].uIntValue
        groupImage = json["photo_100"].stringValue
    }
}
