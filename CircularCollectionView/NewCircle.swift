//
//  NewCircle.swift
//  ParseTesting
//
//  Created by Kayla Kerney on 11/3/15.
//  Copyright (c) 2015 Kayla Kerney. All rights reserved.
//
import Parse
import Foundation
import UIKit

class NewCircle : PFObject, PFSubclassing {
  var circleName : String = ""
  var circleDescription : String = ""
  var circleMembers : [PFUser] = []
  var circleColor : UIColor
  var circlePhotos : [PhotoClass] = []
  
  
  //    override class func initialize() {
  //        var onceToken : dispatch_once_t = 0;
  //        dispatch_once(&onceToken) {
  //            self.registerSubclass()
  //        }
  //    }
  
  class func parseClassName() -> String {
    return "NewCircle"
  }
  
  
  override init()
  {
    self.circleColor = UIColor.clearColor()
    super.init()
  }
  
  init(circleName: String, circleDescription: String, circleMembers: [PFUser], circleColor: UIColor, photos: [UIImage])
  {
    //        var onceToken : dispatch_once_t = 0;
    //        dispatch_once(&onceToken) {
    //            super.registerSubclass()
    //        }
    var newCircle : PFObject!
    self.circleColor = UIColor.clearColor()
    newCircle = PFObject(className: "NewCircle")
    newCircle.setValue(circleName, forKey: "circleName")
    newCircle.setValue(circleDescription, forKey: "circleDescriptions")
    newCircle.setValue(circleMembers, forKey: "circleMembers")
    newCircle.setValue(circleColor, forKey:"circleColor");
    newCircle.setValue(circleMembers, forKey:"circleMembers")
    newCircle.saveInBackgroundWithBlock {
      (success: Bool, error: NSError?) -> Void in
      if (success) {
        // The object has been saved.
      } else {
        print("Error", terminator: "")
      }
    }
    super.init()
  }
  func retrievingCircle(circleName: String) {
    
  }
  
  func addNewPhoto(photo: PhotoClass, circleName: String) -> Bool {
    let query = PFQuery(className: "NewCircle")
    query.whereKey("circleName", equalTo:circleName)
    var circleArray = [PFObject]()
    var photosArray = [PhotoClass]()
    //        do {
    //            circleArray = try query.findObjects()
    //        } catch {
    //            circleArray = []
    //        }
    let object = circleArray[0] as PFObject!
    let circle = object as! CircularCollectionView.NewCircle
    photosArray = circle.circlePhotos
    photosArray.append(photo)
    
    return true;
  }
}