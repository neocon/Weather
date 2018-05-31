//
//  LoginFormController.swift
//  Weather
//
//  Created by Сергей Родионов on 09.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import UIKit
import WebKit

struct Credentials {
    static let validUsername = "admin"
    static let validPassword = "1"
}

class LoginFormController: UIViewController {

   
    @IBOutlet weak var mainWKWebView: WKWebView!{
        didSet{
            mainWKWebView.navigationDelegate = self
        }
    }
    
    var token: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let service = VKService()
        mainWKWebView.load(service.getAuthorizeRequest())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func checkAuth() -> Bool {
        return token! != ""
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let result = checkAuth()
        
        if !result{
            showLoginError()
        }
        
        return result
    }
    
    func showLoginError(){
        let alert = UIAlertController(title: "Error", message: "Wrong login / pass", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

extension LoginFormController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment.components(separatedBy: "&").map {$0.components(separatedBy: "=")}.reduce([String: String]()){
            result, param in
            var dict = result
            let key = param[0]
            let value = param[1]
            dict[key] = value
            return dict
        }
        
        token = params["access_token"]
        print(token)
        
        VarsManager.sharedInstance.vkToken = token!
        VarsManager.sharedInstance.userId = params["user_id"]!
        
        decisionHandler(.cancel)
        
        performSegue(withIdentifier: "LoginSegue", sender: mainWKWebView)
    }
}
