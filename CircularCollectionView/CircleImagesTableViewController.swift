//
//  CircleImagesTableViewController.swift
//  ParseTesting
//
//  Created by Madeline Gilbert on 11/23/15.
//  Copyright © 2015 Kayla Kerney. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts

class CircleImagesTableViewController: UITableViewController {
  
  var circleImagesArray = [PFFile]()
  var circleObjectId = ""
  var actualImagesArray = [UIImage]()
  var circleMembers = [String]()
  var circleName = ""
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.separatorColor = UIColor.whiteColor()
    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
    self.view.backgroundColor = UIColor.darkGrayColor()
    self.tableView.backgroundColor = UIColor.darkGrayColor()
    self.tableView.estimatedRowHeight = 130
    self.tableView.rowHeight = 130
    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLineEtched

    let query2 = PFQuery.init(className: "NewCircle")
    query2.getObjectInBackgroundWithId(circleObjectId) {
        (circle: PFObject?, error: NSError?) -> Void in
        if error == nil && circle != nil {
          let circleActually = circle as! NewCircle
          self.circleImagesArray.removeAll()
          self.circleName = circleActually.objectForKey("circleName") as! String
          if(circleActually.objectForKey("circlePhotos") != nil) {
            self.circleImagesArray = circleActually.objectForKey("circlePhotos") as! [PFFile]
          } else{
            self.circleImagesArray = []
            let alert = UIAlertView(title: "MyCircles", message: "No images to display", delegate:self,cancelButtonTitle: "Done")
            alert.show()
          }
          self.actualImagesArray.removeAll()
          for image in self.circleImagesArray {
            image.getDataInBackgroundWithBlock {
              (imageData: NSData?, error: NSError?) -> Void in
              if (error == nil) {
                print("the image downloaded")
                let image = UIImage(data:imageData!)
                self.actualImagesArray.append(image!)
                self.tableView.reloadData()
              }
            }
          }
          self.tableView.reloadData()
        } else {
          print(error, terminator: "")
        }
      }

    for image in circleImagesArray {
      image.getDataInBackgroundWithBlock {
        (imageData: NSData?, error: NSError?) -> Void in
        if (error == nil) {
          print("the image downloaded")
          let image = UIImage(data:imageData!)
          self.actualImagesArray.append(image!)
          self.tableView.reloadData()
        }
      }
    }
    
    // back circle button
    let backbutton = UIButton(type: UIButtonType.System)
    backbutton.frame = CGRectMake(0,20,100,10)
    backbutton.titleLabel?.font = UIFont(name: (backbutton.titleLabel!.font?.fontName)!, size: 18)
    backbutton.backgroundColor = nil
    backbutton.setTitle("Back", forState: UIControlState.Normal)
    backbutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    backbutton.addTarget(self, action: "goBack:", forControlEvents: UIControlEvents.TouchUpInside)
    view.addSubview(backbutton)

    
    
  }
  
  func goBack(sender: UIButton!) {
    performSegueWithIdentifier("back", sender: sender)
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return actualImagesArray.count;
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath) as! ImageTableViewCell
    cell.cirlceImageView!.image = actualImagesArray[indexPath.row]
    cell.backgroundColor = UIColor.darkGrayColor()
    return cell
  }


  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "back" {
      let viewController = segue.destinationViewController as! ACircleCollectionViewController
      viewController.circleObjectId = self.circleObjectId
      viewController.circleName = self.circleName
    }
    if segue.identifier == "addPhoto" {
      let viewController = segue.destinationViewController as! AddPhotoViewController
      viewController.circleObjectId = self.circleObjectId
    }
  }
}