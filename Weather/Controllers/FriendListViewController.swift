//
//  FriendListViewController.swift
//  Weather
//
//  Created by Сергей Родионов on 20.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import UIKit

class FriendListViewController: UITableViewController {

    var friendsList: [Friend] = [Friend(friendName: "Friend1", friendImage: UIImage(named: "pic")!),
                                 Friend(friendName: "Friend2", friendImage: UIImage(named: "pic")!),
                                 Friend(friendName: "Friend3", friendImage: UIImage(named: "pic")!)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friendsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendListCell", for: indexPath) as! FriendListViewCell
        
        // configure cell
        let flc = friendsList[indexPath.row]
        cell.titleLabel.text = flc.friendName
        cell.imageContainer.image = flc.friendImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }

}
