//
//  SignupViewController.swift
//  ParseTesting
//
//  Created by Madeline Gilbert on 11/4/15.
//  Copyright © 2015 Kayla Kerney. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts

class SignupViewController: UIViewController {
  
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  
  @IBAction func tappedBackground(sender: AnyObject) {
    emailTextField.resignFirstResponder();
    usernameTextField.resignFirstResponder();
    passwordTextField.resignFirstResponder();
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "random_grey_variations.png")!)
    
    //self.navigationController?.navigationBarHidden = false
    
    // set logo to top of screen
    let logoView = UIImageView(image: UIImage(named: "circleslogo.png"))
    let screenWidth = view!.bounds.width
    var frm: CGRect = logoView.frame
    frm.origin.y = frm.origin.y - 125
    frm.size.width = screenWidth
    logoView.frame = frm
    view.addSubview(logoView)
    
  }
  
  @IBAction func createAccount(sender: AnyObject) {
    let user = PFUser()
    user.username = usernameTextField.text!
    user.email = emailTextField.text!
    user.password = passwordTextField.text!
    
 
    
    let defaultPic = UIImage(named: "defaultuserpic.png")
    let photoFile = PFFile(data: UIImageJPEGRepresentation(defaultPic!, 1.0)!)
    user.setObject(photoFile!, forKey: "profilePic")
    user.setObject(["vlfY1qCGMz"], forKey: "circles")
    user.signUpInBackgroundWithBlock {
      (succeeded: Bool, error: NSError?) -> Void in
      if error != nil {
        // Show the errorString somewhere and let the user try again.
        let alert = UIAlertView(title: "MyCircles", message: "Error with signup credentials", delegate:self,cancelButtonTitle: "Done")
        alert.show()
      } else {
        PFUser.logInWithUsernameInBackground(self.usernameTextField.text!, password: self.passwordTextField.text!) { (user, error) -> Void in
          if error == nil {
            self.performSegueWithIdentifier("startApp1", sender: self)
          }
        }
        // Hooray! Let them use the app now.
      }
    }

  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "startApp1") {
      _ = segue.destinationViewController as! UITabBarController
    }
  }
}