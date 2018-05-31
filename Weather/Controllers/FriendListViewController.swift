//
//  FriendListViewController.swift
//  Weather
//
//  Created by Сергей Родионов on 20.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import UIKit

class FriendListViewController: UITableViewController {

    var friendsList: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let service = VKService()
        service.getUserFriends(token: VarsManager.sharedInstance.vkToken){
            [weak self] friends in
            self?.friendsList = friends
            self?.tableView.reloadData()
        }
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
        cell.configure(friend: flc)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photoController = segue.destination as? FriendPhotosViewController {
            photoController.owner = ((sender as? FriendListViewCell)?.friendId)!
        }
    }

}
