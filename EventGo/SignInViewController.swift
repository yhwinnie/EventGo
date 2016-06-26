//
//  SignInViewController.swift
//  EventGo
//
//  Created by Nicholas Swift on 6/25/16.
//  Copyright © 2016 djku. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func signInAction(sender: AnyObject) {
        
        let errorRedColor = UIColor(red: 241/255, green: 0/255, blue: 0/255, alpha: 255/255)
        let errorGreenColor = UIColor(red: 67/255, green: 160/255, blue: 157/255, alpha: 255/255)
        
        // Start fade out
        self.errorLabel.fadeOut(completion: {
            (finished: Bool) -> Void in
            
            ServerHelper.attemptLogIn(self.usernameField.text, password: self.passwordField.text)
            if(ServerHelper.userLoggedIn! == true) {
                self.errorLabel.textColor = errorGreenColor
                self.errorLabel.text = "Successfully signed in."
                self.errorLabel.fadeIn(completion: {
                    (finished: Bool) -> Void in
                    self.performSegueWithIdentifier("MapSegue", sender: sender)
                })
                
                //self.performSegueWithIdentifier("MapSegue", sender: sender)
                
            }
            else {
                self.errorLabel.textColor = errorRedColor
                self.errorLabel.text = "The email or password is incorrect."
            }
            
            // Start fade in
            self.errorLabel.fadeIn()
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    @IBAction func signUpAction(sender: AnyObject) {
        
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change text of certain things
        errorLabel.text = ""
        
        // Make keyboard go down when tapped outside
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
}

extension UIView {
    func fadeIn(duration: NSTimeInterval = 0.5, delay: NSTimeInterval = 0.0, completion: (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 1.0
            }, completion: completion)  }
    
    func fadeOut(duration: NSTimeInterval = 0.5, delay: NSTimeInterval = 0.0, completion: (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 0.0
            }, completion: completion)
    }
}
