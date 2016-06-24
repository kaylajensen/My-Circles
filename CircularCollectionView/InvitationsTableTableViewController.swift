//
//  InvitationsTableViewController.swift
//  CircularCollectionView
//
//  Created by Madeline Gilbert on 12/10/15.
//  Copyright © 2015 Rounak Jain. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts

class InvitationsTableViewController: UITableViewController {
  var invitations = [AnyObject]()
  var circleObject = PFObject(className: "NewCircle")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.separatorColor = UIColor.whiteColor()
    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
    self.view.backgroundColor = UIColor.darkGrayColor()
    self.tableView.backgroundColor = UIColor.darkGrayColor()
    self.tableView.estimatedRowHeight = 250
    self.tableView.rowHeight = 250
    self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "random_grey_variations.png")!)
    
    let currentUser = PFUser.currentUser()
    let query = PFQuery(className: "Invitation")
    query.whereKey("recipientId", equalTo:(currentUser?.objectId)!)
    query.findObjectsInBackgroundWithBlock { (invitationsArray: [PFObject]?,error: NSError?) -> Void in
      if(error == nil) {
        for invitation in invitationsArray! {
          self.invitations.append(invitation)
        }
        self.tableView.reloadData()
      } else {
        print("error")
      }
    }
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return invitations.count;
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("invitationCell", forIndexPath: indexPath) as! InvitationTableViewCell
    cell.acceptButton.tag = indexPath.row
    cell.rejectButton.tag = indexPath.row
    let invitation = invitations[indexPath.row] as! PFObject
    let query = PFQuery(className: "NewCircle")
    if(circleObject.objectForKey("circleName") == nil)  {
      query.getObjectInBackgroundWithId((invitation.objectForKey("circleId") as? String)!) { (object: PFObject?,error: NSError?) -> Void in
        self.circleObject = object!
        self.tableView.reloadData()
      }
    }
    else {
      cell.nameLabel.text = invitation.objectForKey("circleName") as? String
      cell.descriptionLabel.text = invitation.objectForKey("circleDescription") as? String
      cell.createdByLabel.text = invitation.objectForKey("circleCreator") as? String
      var membersString = ""
      for member in invitation.objectForKey("circleMembers") as! [String] {
        membersString = membersString + member + " "
      }
      cell.membersLabel.text = membersString
      cell.messageLabel.text = invitation.objectForKey("inviteMessage") as? String
      cell.nameLabel.text = circleObject.objectForKey("circleName") as? String
      cell.descriptionLabel.text = circleObject.objectForKey("circleDescription") as? String
      
    }
    cell.backgroundColor = UIColor.darkGrayColor()
    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  }
  @IBAction func acceptInvitation(sender: AnyObject) {
    let invitationToAccept = invitations[sender.tag]
    let user = PFUser.currentUser()
    user!.addObject(invitationToAccept.objectForKey("circleId")!, forKey:"circles")
    user!.saveInBackground()
    self.tableView.reloadData()
    invitationToAccept.deleteInBackgroundWithBlock({ (didDelete: Bool, error: NSError?) -> Void in
      if(error == nil) {
        
        self.invitations.removeAtIndex(sender.tag)
        self.tableView.reloadData()
        
      }
    })
  }
  
  
  @IBAction func rejectInvitation(sender: AnyObject) {
    let invitationToReject = invitations[sender.tag]
    invitations.removeAtIndex(sender.tag)
    self.tableView.reloadData()
    invitationToReject.deleteInBackgroundWithBlock({ (didDelete: Bool, error: NSError?) -> Void in
      if(error == nil) {
        
      }
    })
  }
}