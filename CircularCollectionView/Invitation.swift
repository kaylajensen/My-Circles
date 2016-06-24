 //
 //  Invitation.swift
 //  CircularCollectionView
 //
 //  Created by Madeline Gilbert on 12/10/15.
 //  Copyright © 2015 Madeline Gilbert. All rights reserved.
 //
 
 import Foundation
 import Bolts
 import Parse
 
 class Invitation : PFObject, PFSubclassing {
  var circleId : String = ""
  var circleCreator : String = ""
  var inviteMessage : String = ""
  
  class func parseClassName() -> String {
    return "Invitation"
  }
  
  override init() {
    super.init()
  }
  
  class func createInvitationAndStoreForMember(inviteMessage : String, circleCreator : String, circleId : String, circleMember : String, circleMembers : [String]) -> Bool {
    var returnVal = false
    if (circleMember != "") {
      let newInvitation = PFObject(className: "Invitation")
      newInvitation["circleCreator"] = circleCreator;
      newInvitation["circleId"] = circleId;
      newInvitation["inviteMessage"] = inviteMessage;
      newInvitation["circleMembers"] = circleMembers
      newInvitation.saveInBackgroundWithBlock{ (succeeded, error) -> Void in
        if error == nil {
          let query = PFUser.query()
          query!.whereKey("email", equalTo:circleMember)
          query!.getFirstObjectInBackgroundWithBlock({ (user: PFObject?, error: NSError?) -> Void in
            if(error == nil) {
              let userObject = user as! PFUser
              newInvitation["recipientId"] = userObject.objectId
              newInvitation.saveInBackground()
              returnVal = true
            } else {
            }
          })
          
        }
          
        else {
          print("\(error)");
        }
      }
    }
    return returnVal
  }
 }