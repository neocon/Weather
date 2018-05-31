//
//  ImageViewCell.swift
//  Weather
//
//  Created by Сергей Родионов on 21.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import UIKit
import Kingfisher

class ImageViewCell: UICollectionViewCell {
    @IBOutlet weak var bigImageContainer: UIImageView!
    
    func configure(photo: Photo){
        if let iconURL = URL(string: photo.photoUrl) {
            bigImageContainer.kf.setImage(with: iconURL)
        }
    }
}
