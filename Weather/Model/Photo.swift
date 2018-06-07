//
//  Photo.swift
//  Weather
//
//  Created by Сергей Родионов on 31.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Photo: Object {
    @objc dynamic var photoId: UInt = 0
    @objc dynamic var photoUrl: String = ""
    @objc dynamic var ownerId: UInt = 0
    
    convenience init(json: JSON){
        self.init()
        
        self.photoId = json["id"].uIntValue
        self.photoUrl = json["sizes"][0]["url"].stringValue
        self.ownerId = json["owner_id"].uIntValue
    }
}
