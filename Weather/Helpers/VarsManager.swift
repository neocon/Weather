//
//  VarsManager.swift
//  Weather
//
//  Created by Сергей Родионов on 28.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import Foundation

class VarsManager{
    var vkToken = ""
    var userId = ""
    
    static let sharedInstance = VarsManager()
    
    init(){
        
    }
    
    func reset(){
        vkToken = ""
        userId = ""
    }
}
