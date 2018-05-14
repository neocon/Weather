//
//  LoginFormController.swift
//  Weather
//
//  Created by Сергей Родионов on 09.05.2018.
//  Copyright © 2018 Сергей Родионов. All rights reserved.
//

import UIKit

struct Credentials {
    static let validUsername = "admin"
    static let validPassword = "1"
}

class LoginFormController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.mainScrollView.addGestureRecognizer(hideKeyboardGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func checkAuth() -> Bool {
        guard let login = usernameTextField.text, let password = passwordTextField.text else {
            return false
        }
        
        if login == Credentials.validUsername && password == Credentials.validPassword {
            return true
        }
        
        return false
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
    
    @IBAction func loginButtonPress(_ sender: Any) {
//        if checkAuth(){
//            performSegue(withIdentifier: "LoginSegue", sender: sender)
//            print("Success login")
//        }
//        else{
//            let alert = UIAlertController(title: "Error", message: "Wrong login / pass", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            present(alert, animated: true, completion: nil)
//        }
    }
    
    @objc func keyboardWasShown(notification: Notification){
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0)
        
        self.mainScrollView.contentInset = contentInsets
        self.mainScrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification){
        let contentInsets = UIEdgeInsets.zero
        
        self.mainScrollView.contentInset = contentInsets
        mainScrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func hideKeyboard(){
        self.mainScrollView.endEditing(true)
    }

}


