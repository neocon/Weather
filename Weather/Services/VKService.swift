//
//  VKService.swift
//  Weather
//
//  Created by Сергей Родионов on 28.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import Foundation
import WebKit
import Alamofire
import SwiftyJSON
import RealmSwift

class VKService {
    let authHost = "oauth.vk.com"
    let apiHost = "api.vk.com"
    let clientID = "6491468"
    
    func getAuthorizeRequest() -> URLRequest{
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = authHost
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://" + authHost + "/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        return URLRequest(url: urlComponents.url!)
    }
    
    func getUserFriends(token: String, completion: @escaping() -> Void){
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = apiHost
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: VarsManager.sharedInstance.vkToken),
            URLQueryItem(name: "user_id", value: VarsManager.sharedInstance.userId),
            URLQueryItem(name: "v", value: "5.78"),
            URLQueryItem(name: "fields", value: "nickname, sex, bdate, city, country, photo_100")
        ]
        
        Alamofire.request(urlComponents.url!).responseJSON{
            response in
            guard let data = response.value else {return}
            
            let json = JSON(data)
            let friends = json["response"]["items"].flatMap{Friend(json: $0.1)}
            self.saveFriends(friends: friends)
            
            for fr in friends{
                self.getUserPhoto(token: token, owner: fr.friendId){}
            }
            
            completion()
        }
    }
    
    func getUserGroups(token: String, completion: @escaping() -> Void){
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = apiHost
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: VarsManager.sharedInstance.vkToken),
            URLQueryItem(name: "user_id", value: VarsManager.sharedInstance.userId),
            URLQueryItem(name: "v", value: "5.78"),
            URLQueryItem(name: "fields", value: "members_count"),
            URLQueryItem(name: "extended", value: "1")
        ]
        
        Alamofire.request(urlComponents.url!).responseJSON{
            response in
            guard let data = response.value else {return}
            
            let json = JSON(data)
            let groups = json["response"]["items"].flatMap{Group(json: $0.1)}
            self.saveGroups(groups: groups)
            completion()
        }
    }
    
    func getUserPhoto(token: String, owner: UInt, completion: @escaping() -> Void){
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = apiHost
        urlComponents.path = "/method/photos.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: VarsManager.sharedInstance.vkToken),
            URLQueryItem(name: "owner_id", value: String(owner)),
            URLQueryItem(name: "v", value: "5.78"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "album_id", value: "wall")
        ]
        
        Alamofire.request(urlComponents.url!).responseJSON{
            response in
            guard let data = response.value else {return}
            
            let json = JSON(data)
            let photos = json["response"]["items"].flatMap{Photo(json: $0.1)}
            self.saveFriendPhotos(photos: photos)
            completion()
        }
    }
    
    func searchGroups(token: String, searchString: String, completion: @escaping([Group]) -> Void){
        var urlComponents = URLComponents()
    
        urlComponents.scheme = "https"
        urlComponents.host = apiHost
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
        URLQueryItem(name: "access_token", value: VarsManager.sharedInstance.vkToken),
        URLQueryItem(name: "user_id", value: VarsManager.sharedInstance.userId),
        URLQueryItem(name: "v", value: "5.78"),
        URLQueryItem(name: "fields", value: "members_count"),
        URLQueryItem(name: "q", value: "'" + searchString + "'"),
        URLQueryItem(name: "count", value: "200")
        ]
    
        Alamofire.request(urlComponents.url!).responseJSON{
            response in
            guard let data = response.value else {return}
        
            let json = JSON(data)
            let groups = json["response"]["items"].flatMap{Group(json: $0.1)}
            
            //saveGroups(groups)
            
            completion(groups)
        }
    }
    
    func saveFriends(friends: [Friend]){
        do{
            let realm = try Realm()
            realm.beginWrite()
            realm.add(friends)
            try realm.commitWrite()
        }catch{
            print(error)
        }
    }
    
    func saveGroups(groups: [Group]){
        do{
            let realm = try Realm()
            realm.beginWrite()
            realm.add(groups)
            try realm.commitWrite()
        }catch{
            print(error)
        }
    }
    
    func saveFriendPhotos(photos: [Photo]){
        do{
            let realm = try Realm()
            realm.beginWrite()
            realm.add(photos)
            try realm.commitWrite()
        }catch{
            print(error)
        }
    }
    
    func updateData(token: String){
        getUserFriends(token: token){}
        getUserGroups(token: token){}
    }
}
