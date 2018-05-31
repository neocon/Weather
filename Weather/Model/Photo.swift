//
//  Photo.swift
//  Weather
//
//  Created by Сергей Родионов on 31.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import Foundation
import SwiftyJSON

class Photo {
    var photoId: UInt
    var photoUrl: String
    
    init(json: JSON){
        photoId = json["id"].uIntValue
        photoUrl = json["sizes"][0]["url"].stringValue
    }
}
