//
//  Group.swift
//  Weather
//
//  Created by Сергей Родионов on 21.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import Foundation
import UIKit

class Group{
    var groupName:String
    var groupImage: UIImage
    var groupPopulation: UInt
    
    init(groupName: String, groupImage: UIImage, groupPopulation: UInt) {
        self.groupImage = groupImage
        self.groupName = groupName
        self.groupPopulation = groupPopulation
    }
}
