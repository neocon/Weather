//
//  FriendPhotosViewController.swift
//  Weather
//
//  Created by Сергей Родионов on 21.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import UIKit
import RealmSwift


class FriendPhotosViewController: UICollectionViewController {

    var photoList: [Photo] = []
    var owner: UInt = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let service = VKService()
//        service.getUserPhoto(token: VarsManager.sharedInstance.vkToken, owner: owner){
//            [weak self] photos in
//            self?.photoList = photos
//            self?.collectionView?.reloadData()
//        }
        
        do{
            let realm = try Realm()
            let up = realm.objects(Photo.self).filter("ownerId==%@", owner);
            self.photoList = Array(up)
        }
        catch{
            print(error)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photoList.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageViewCell
    
        let ph = photoList[indexPath.row]
        cell.configure(photo: ph)
    
        return cell
    }
}
