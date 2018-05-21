//
//  GropListViewController.swift
//  Weather
//
//  Created by Сергей Родионов on 21.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import UIKit

class GroupListViewController: UITableViewController {

    var groupList: [Group] = [Group(groupName: "Group1", groupImage: UIImage(named: "pic")!, groupPopulation: 100)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupList.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupListCell", for: indexPath) as! GroupListViewCell

        let group = groupList[indexPath.row]
        cell.groupNameLabel.text = group.groupName
        cell.imageContainer.image = group.groupImage

        return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue)
    {
        if segue.identifier == "addGroup"{
            let allGroupListController = segue.source as! AllGroupListViewController
            
            if let index = allGroupListController.tableView.indexPathForSelectedRow{
                let group = allGroupListController.groupList[index.row]
                
                let contains: Bool = groupList.contains { $0.groupName == group.groupName }
                
                if (!contains)
                {
                    groupList.append(group)
                    tableView.reloadData()
                }
            }
        }
    }

}
