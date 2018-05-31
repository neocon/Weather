//
//  AllGroupListViewController.swift
//  Weather
//
//  Created by Сергей Родионов on 21.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import UIKit

class AllGroupListViewController: UITableViewController, UISearchBarDelegate {

    var groupList: [Group] = []
    var searchActive : Bool = false
    var filtered: [Group] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        let service = VKService()
        service.searchGroups(token: VarsManager.sharedInstance.vkToken, searchString: ""){
            [weak self] groups in
            self?.groupList = groups
            self?.tableView.reloadData()
        }
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
        
        VKService().searchGroups(token: VarsManager.sharedInstance.vkToken, searchString: searchText){
            [weak self] groups in
            let gr = groups
            self?.filtered = gr
        }
        
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
            cell.configure(group: group)
        } else {
            let group = groupList[indexPath.row]
            cell.configure(group: group)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
}
