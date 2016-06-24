//
//  CreateCircleViewController.swift
//  CircularCollectionView
//
//  Created by Madeline Gilbert on 12/7/15.
//  Copyright © 2015 Rounak Jain. All rights reserved.
//
import Foundation
import UIKit
import Parse
import Bolts

class CreateCircleViewController: UIViewController {
  
  @IBOutlet weak var circleName: UITextField!
  @IBOutlet weak var circleDescription: UITextField!
  @IBOutlet weak var member1: UITextField!
  @IBOutlet weak var member2: UITextField!
  @IBOutlet weak var member3: UITextField!
  @IBOutlet weak var member4: UITextField!
  
  @IBOutlet weak var messageTextView: UITextField!
  
  var membersArray = [String]()
  
  
    @IBAction func tappedBackground(sender: AnyObject) {
      member1.resignFirstResponder()
      member2.resignFirstResponder()
      member3.resignFirstResponder()
      member4.resignFirstResponder()
      messageTextView.resignFirstResponder()
      circleDescription.resignFirstResponder()
      circleName.resignFirstResponder()
    }
  
  @IBAction func createCircle(sender: AnyObject) {
    let newCircle = PFObject(className: "NewCircle")
    let invitationMessage = messageTextView.text!
    
    newCircle["circleName"] = self.circleName.text
    newCircle["circleDescription"] = self.circleDescription.text
    
    membersArray.append(self.member1.text!)
    membersArray.append(self.member2.text!)
    membersArray.append(self.member3.text!)
    membersArray.append(self.member4.text!)
    
    newCircle["circleMembers"] = membersArray
    let currentUser = PFUser.currentUser()
    
    newCircle.saveInBackgroundWithBlock { (success, error) -> Void in
      if success {
      
        var user1 = false
        var user2 = false
        var user3 = false
        var user4 = false
        
        self.membersArray.append(currentUser!.email!)
        user1 = Invitation.createInvitationAndStoreForMember(invitationMessage, circleCreator: currentUser!.username!, circleId: newCircle.objectId!, circleMember: self.membersArray[0], circleMembers: self.membersArray)
        user2 = Invitation.createInvitationAndStoreForMember(invitationMessage, circleCreator: currentUser!.username!, circleId: newCircle.objectId!, circleMember: self.membersArray[1], circleMembers: self.membersArray)
        user3 = Invitation.createInvitationAndStoreForMember(invitationMessage, circleCreator: currentUser!.username!, circleId: newCircle.objectId!, circleMember: self.membersArray[2], circleMembers: self.membersArray)
        user4 = Invitation.createInvitationAndStoreForMember(invitationMessage, circleCreator: currentUser!.username!, circleId: newCircle.objectId!, circleMember: self.membersArray[3], circleMembers: self.membersArray)
        
        if !(user1 && user2 && user3 && user4){
          let alert = UIAlertView(title: "MyCircles", message: "Unable to send all invitations. Could not find emails", delegate:self,cancelButtonTitle: "OK")
          alert.show()
        } else {
          let alert = UIAlertView(title: "MyCircles", message: "Circle created", delegate:self,cancelButtonTitle: "OK")
          alert.show()
        }
        
        // CORRECTLY SAVES THE RIGHT OBJECT ID FOR EACH CIRCLE TO CORRECT USER
        let ojId = newCircle.objectId
        var test = PFUser.currentUser()?.objectForKey("circles") as! [String]
        print(test)
        test.append(ojId!)
        print(test)
        currentUser!.setObject(test, forKey: "circles")
        currentUser!.saveInBackground()
        
        
      
      } else { print("\(error)"); }
    }
    
    
    // KAYLAS CODE
//            let ojId = newCircle.objectId! as String
//            print(currentUser?.username)
//            var test = PFUser.currentUser()?.objectForKey("circles") as! [String]
//            print(test)
//            test.append(ojId)
//            print(test)
//            currentUser!.setObject(test, forKey: "circles")
//            currentUser!.saveInBackground()
    
    self.performSegueWithIdentifier("createCircle", sender: nil)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "random_grey_variations.png")!)
    
    // back circle button
    let backbutton = UIButton(type: UIButtonType.System)
    backbutton.frame = CGRectMake(0,20,100,10)
    backbutton.titleLabel?.font = UIFont(name: (backbutton.titleLabel!.font?.fontName)!, size: 18)
    backbutton.backgroundColor = nil
    backbutton.setTitle("Cancel", forState: UIControlState.Normal)
    backbutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    backbutton.addTarget(self, action: "goBack:", forControlEvents: UIControlEvents.TouchUpInside)
    view.addSubview(backbutton)
    
  }
  func goBack(button: UIButton!) {
    self.performSegueWithIdentifier("backagain", sender: nil)
  }
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //self.navigationController?.popToRootViewControllerAnimated(true)
    if(segue.identifier == "createCircle") {
      print("made it to prepare for segue in createCircle")
          member1.resignFirstResponder()
          member2.resignFirstResponder()
          member3.resignFirstResponder()
          member4.resignFirstResponder()
          messageTextView.resignFirstResponder()
          circleDescription.resignFirstResponder()
          circleName.resignFirstResponder()
      _ = segue.destinationViewController as! UITabBarController
    }
//    if(segue.identifier == "backagain") {
//      
//    }
  }
}
