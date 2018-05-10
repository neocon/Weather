//
//  UIView+Layer.swift
//  Weather
//
//  Created by Сергей Родионов on 09.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import UIKit

extension UIView{
    @IBInspectable var cornerRadius: CGFloat{
        get{
            return layer.cornerRadius
        }
        
        set{
            layer.cornerRadius = newValue
        }
    }
}
