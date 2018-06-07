//
//  GropListViewController.swift
//  Weather
//
//  Created by Сергей Родионов on 21.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import UIKit
import RealmSwift

class GroupListViewController: UITableViewController {

    var groupList: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let service = VKService()
//        service.getUserGroups(token: VarsManager.sharedInstance.vkToken){
//            [weak self] groups in
//            self?.groupList = groups
//            self?.tableView.reloadData()
//        }
        
        do{
            let realm = try Realm()
            let gl = realm.objects(Group.self);
            self.groupList = Array(gl)
        }
        catch{
            print(error)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupList.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupListCell", for: indexPath) as! GroupListViewCell

        let group = groupList[indexPath.row]
        cell.configure(group: group)

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
