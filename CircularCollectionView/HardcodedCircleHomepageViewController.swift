//
//  HardcodedCircleHomepageViewController.swift
//  ParseTesting
//
//  Created by Madeline Gilbert on 11/23/15.
//  Copyright © 2015 Kayla Kerney. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts

class HardcodedCircleHomepageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var circleNameLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  var circleName = ""
  var circleDescription = ""
  var circleMembers = []
  var circleImages = [PFFile]()
  var circleObjectId = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "random_grey_variations.png")!)
    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
    self.tableView.backgroundColor = UIColor.darkGrayColor()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorColor = UIColor.whiteColor()
    //do logic for getting circle members and photos and pass to circle view controller
    self.descriptionLabel.text = circleDescription
    self.circleNameLabel.text = circleName
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
    return circleMembers.count
  }
  
  func numberOfSectionsInTableView(tableView:UITableView) -> Int {
    return 1
  }
  
  
  func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
    
    let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
    
    cell.textLabel?.text = circleMembers[indexPath.row] as? String
    cell.backgroundColor = UIColor.darkGrayColor()

    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "circlePictures" {
      let viewController = segue.destinationViewController as! CircleImagesTableViewController
      viewController.circleObjectId = self.circleObjectId
      viewController.circleImagesArray = self.circleImages
      viewController.circleMembers = self.circleMembers as! [String]
      viewController.circleName = self.circleName
    }
//    else if segue.identifier == "addPhoto" {
//      let viewController = segue.destinationViewController as! AddPhotoViewController
//      viewController.circleObjectId = self.circleObjectId
//    }
  }
  
}
