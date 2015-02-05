//
//  LoginViewController.swift
//  Sit Fit
//
//  Created by Jo Albright on 2/3/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfLoggedIn()
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification: NSNotification!) -> Void in
            
            if let kbSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size {
                
                self.buttonBottomConstraint.constant = 20 + kbSize.height
                
                // used to animate constraint
                self.view.layoutIfNeeded()
                
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            self.buttonBottomConstraint.constant = 20
            
            // used to animate constraint
            self.view.layoutIfNeeded()
            
        }
        
        
    }
    
    @IBAction func loginRegister(sender: AnyObject) {
        
//        isLoggedIn = true
//        
//        checkIfLoggedIn()
        
        var fieldValues: [String] = [usernameField.text,passwordField.text]
        
        if find(fieldValues, "") != nil {
            
            // all fields are not filled in
            var alertViewController = UIAlertController(title: "Submission Error", message: "All fields need to be filled in.", preferredStyle: UIAlertControllerStyle.Alert)
            
            //            UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
            //            handler:^(UIAlertAction * action) {}];
            
            var defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            
            alertViewController.addAction(defaultAction)
            
            presentViewController(alertViewController, animated: true, completion: nil)
            
        } else {
            
            // all fields are filled in
            
            println("all fields are good and login")
            
            var userQuery = PFUser.query()
            
            userQuery.whereKey("username", equalTo: usernameField.text)
            
            userQuery.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                
                if objects.count > 0 {
                    
                    self.login()
                    
                } else {
                    
                    self.signUp()
                    
                }
                
            })
            
        }
        
        
    }
    
    func login() {
        
        PFUser.logInWithUsernameInBackground(usernameField.text, password:passwordField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            
            if user != nil {
                
                println("logged in as \(user)")
                // Do stuff after successful login.
                
                self.isLoggedIn = true
                self.checkIfLoggedIn()
                
            } else {
                // The login failed. Check error to see why.
            }
            
        }
        
    }
    
    func signUp() {
        
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
//        user.email = emailField.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            
            if error == nil {
                
                println(user)
                
                self.isLoggedIn = true
                self.checkIfLoggedIn()
                
                self.usernameField.text = ""
                self.passwordField.text = ""
//                self.emailField.text = ""
                
                // Hooray! Let them use the app now.
                
            } else {
                
                let errorString = error.userInfo?["error"] as NSString
                // Show the errorString somewhere and let the user try again.
                
            }
            
        }
        
    }
    
    
    var isLoggedIn: Bool {
        
        get {
            
            return NSUserDefaults.standardUserDefaults().boolForKey("isLoggedIn")
            
        }
        
        set {
            
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "isLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
        
    }
    
    func checkIfLoggedIn() {
                
        if isLoggedIn {
         
            var tbc = storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as? UITabBarController
            
            UIApplication.sharedApplication().keyWindow?.rootViewController = tbc
            
        }
        
    }

} // END








