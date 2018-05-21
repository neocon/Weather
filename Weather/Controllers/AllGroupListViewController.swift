//
//  AllGroupListViewController.swift
//  Weather
//
//  Created by Сергей Родионов on 21.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import UIKit

class AllGroupListViewController: UITableViewController, UISearchBarDelegate {

    var groupList: [Group] = [Group(groupName: "Group1", groupImage: UIImage(named: "pic")!, groupPopulation: 100),
                              Group(groupName: "Group2", groupImage: UIImage(named: "pic")!, groupPopulation: 200),
                              Group(groupName: "Group3", groupImage: UIImage(named: "pic")!, groupPopulation: 1200),
                              Group(groupName: "Group4", groupImage: UIImage(named: "pic")!, groupPopulation: 1300),
                              Group(groupName: "Group5", groupImage: UIImage(named: "pic")!, groupPopulation: 2100)]
    var searchActive : Bool = false
    var filtered: [Group] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    //MARK: -Search functions
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = groupList.filter({ (gr) -> Bool in
            let tmp: NSString = NSString(string: gr.groupName)
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        
        return groupList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupListCell", for: indexPath) as! AllGroupListViewCell

        if(searchActive){
            let group = filtered[indexPath.row]
            cell.groupName.text = group.groupName
            cell.imageContainer.image = group.groupImage
            cell.populationLabel.text = String(group.groupPopulation)
        } else {
            let group = groupList[indexPath.row]
            cell.groupName.text = group.groupName
            cell.imageContainer.image = group.groupImage
            cell.populationLabel.text = String(group.groupPopulation)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
}
