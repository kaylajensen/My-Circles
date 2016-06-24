//
//  LoginViewController.swift
//  ParseTesting
//
//  Created by Madeline Gilbert on 11/4/15.
//  Copyright © 2015 Kayla Kerney. All rights reserved.
//

import UIKit
import Parse
import Bolts

class LoginViewController: UIViewController {
  
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var usernameTextField: UITextField!
  
  @IBAction func tappedBackground(sender: AnyObject) {
    usernameTextField.resignFirstResponder();
    passwordTextField.resignFirstResponder();
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "random_grey_variations.png")!)

    //self.navigationController?.navigationBarHidden = true
    
    // set logo to top of screen
    let logoView = UIImageView(image: UIImage(named: "circleslogo.png"))
    let screenWidth = view!.bounds.width
    var frm: CGRect = logoView.frame
    frm.origin.y = frm.origin.y - 125
    frm.size.width = screenWidth
    logoView.frame = frm
    view.addSubview(logoView)
    
    let currentUser = PFUser.currentUser()
    if currentUser != nil {
      //segue and move on
      self.performSegueWithIdentifier("startApp", sender: nil)
      dispatch_async(dispatch_get_main_queue()) {
        [unowned self] in
        self.performSegueWithIdentifier("startApp", sender: self)
      }
    }
  }
  
  @IBAction func signInToAccount(sender: AnyObject) {
//    PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!)
//    
//    self.performSegueWithIdentifier(("startApp"), sender: self)
    
    PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!) { (user, error) -> Void in
      if error == nil {
        self.performSegueWithIdentifier("startApp", sender: nil)
      } else {
        let alert = UIAlertView(title: "MyCircles", message: "Error with login credentials", delegate:self,cancelButtonTitle: "Done")
        alert.show()
      }
    }
//    usernameTextField.text! = "kaylanew"
//    passwordTextField.text! = "nicole12"
//    self.performSegueWithIdentifier("startApp", sender: self)
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "signUp") {
      _ = segue.destinationViewController as! SignupViewController
    }
    if (segue.identifier == "startApp") {
      _ = segue.destinationViewController as! UITabBarController
    }
  }
}