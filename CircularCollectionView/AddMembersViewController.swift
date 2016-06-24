//
//  AddMembersViewController.swift
//  CircularCollectionView
//
//  Created by Kayla Kerney on 12/12/15.
//  Copyright © 2015 Rounak Jain. All rights reserved.
//

import UIKit
import Parse
import Bolts

class AddMembersViewController: UIViewController {
  
  var circleName : String?
  var circleObjectId : String?
  var circleMembers = ["Loading Members...","Loading Members..."]
  var circles = []
  var currentUser : PFObject?
  
    override func viewDidLoad() {
        super.viewDidLoad()

      

      
      
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
