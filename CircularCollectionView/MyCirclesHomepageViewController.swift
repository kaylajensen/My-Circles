

//
//  MyCirclesHomepageViewController.swift
//  ParseTesting
//
//  Created by Madeline Gilbert on 11/24/15.
//  Copyright © 2015 Kayla Kerney. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts

class MyCirclesHomepageViewController : UIViewController
{
  @IBOutlet weak var circleDescriptionLabel: UILabel!
  @IBOutlet weak var circle1: UILabel!
  var circleName = ""
  var circleDescription = ""
  var circleMembers = []
  var circleImages = [PFFile]()
  var circleObjectId = ""
  var circles = []
  var currentUser : PFObject!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "random_grey_variations.png")!)
    
    self.navigationController?.navigationBarHidden = false
    
    // set logo to top of screen
    let logoView = UIImageView(image: UIImage(named: "circleslogo.png"))
    let screenWidth = view!.bounds.width
    var frm: CGRect = logoView.frame
    frm.origin.y = frm.origin.y - 125
    frm.size.width = screenWidth
    logoView.frame = frm
    view.addSubview(logoView)
    
    self.circle1.text = circleName;
    
    let query2 = PFQuery.init(className: "NewCircle")
    query2.getObjectInBackgroundWithId(circleObjectId) {
      (circle: PFObject?, error: NSError?) -> Void in
      if error == nil && circle != nil {
        let circleActually = circle as! NewCircle
        self.circleMembers = circleActually.objectForKey("circleMembers") as! NSArray
        self.circleDescription = circleActually.objectForKey("circleDescription") as! String
        if (circleActually.objectForKey("circlePhotos") != nil) {
          self.circleImages = circleActually.objectForKey("circlePhotos") as! [PFFile]
        }
        else {
          self.circleImages = []
        }
        self.circleDescriptionLabel.text = self.circleDescription
      } else {
        //            let alert = UIAlertView(title: "MyCircles", message: "This circle no longer exists", delegate:self,cancelButtonTitle: "OK")
        //            alert.show()
        //            print(error, terminator: "")
        //            self.navigationController?.popToRootViewControllerAnimated(true)
      }
      
    }
  }
  
  // DELETE CIRCLE CODE
  
  //  @IBAction func deleteCircle(sender: AnyObject) {
  //    circleActually.deleteInBackground()
  //    let alert = UIAlertView(title: "MyCircles", message: "Deleted circle", delegate:self,cancelButtonTitle: "OK")
  //    alert.show()
  //    self.navigationController?.popToRootViewControllerAnimated(true)
  //  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "circleHomepage" {
      let viewController = segue.destinationViewController as! HardcodedCircleHomepageViewController
      viewController.circleDescription = self.circleDescription
      viewController.circleName = self.circleName
      viewController.circleMembers = self.circleMembers
      viewController.circleImages = self.circleImages
      viewController.circleObjectId = self.circleObjectId
    }
    else if segue.identifier == "addPhoto" {
      let viewController = segue.destinationViewController as! AddPhotoViewController
      viewController.circleObjectId = self.circleObjectId
    }
  }
  
}
