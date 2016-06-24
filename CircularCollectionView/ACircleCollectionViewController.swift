

import UIKit
import Parse


let reuseIdentifier2 = "ACell"


class ACircleCollectionViewController: UICollectionViewController {
  
  // set all circle images to images in Images folder
  
  var images1 : [String]?
  
  var circleName : String?
  var circleObjectId : String?
  var circleDescription : String?
  var circleMembers = [String]()
  var circleImages : [PFFile]?
  var circles = []
  var currentUser : PFObject?
  var done = false
  var descripLabel = UILabel()
  var circleActually : NewCircle!
  var descriptionLabel : UILabel = UILabel()

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    let query2 = PFQuery(className: "NewCircle")
    circleMembers.removeAll()
    self.circleMembers.append("Add New Memeber")
    query2.getObjectInBackgroundWithId(circleObjectId!) {
      
      (circle: PFObject?, error: NSError?) -> Void in
      
      if error == nil && circle != nil {
        self.circleActually = circle as! NewCircle
        let circleMembersArray = self.circleActually.objectForKey("circleMembers") as! [String]
        for circleMember in circleMembersArray {
          if circleMember != "" {
            self.circleMembers.append(circleMember)
          }
        }
        self.collectionView?.reloadData()

        self.circleDescription = self.circleActually.objectForKey("circleDescription") as? String
        // description label
        if (self.circleActually.objectForKey("circlePhotos") != nil) {
          self.circleImages = self.circleActually.objectForKey("circlePhotos") as? [PFFile]
        }
        else {
          self.circleImages = []
        }
        
        dispatch_async(dispatch_get_main_queue()) {
          self.descripLabel.text = self.circleDescription
          self.view.addSubview(self.descripLabel)
        }
        
      } else {
        print(error, terminator: "")
      }
      
    }
    // description label
    self.descripLabel.text = self.circleDescription
    self.descripLabel.textColor = UIColor.whiteColor()
    let myX = collectionView!.contentOffset.x+(CGRectGetWidth(collectionView!.bounds)*0.35)
    let myY =  collectionView!.contentOffset.y + (CGRectGetHeight(collectionView!.bounds)*0.25)
    descripLabel.frame = CGRectMake(myX,myY,collectionView!.bounds.width,15)
    self.view.addSubview(descripLabel)

  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // register cell classes
    collectionView!.registerNib(UINib(nibName: "ACircleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier2)
    
    // set background .png image view
    let imageView = UIImageView(image: UIImage(named: "random_grey_variations.png"))
    imageView.contentMode = UIViewContentMode.ScaleAspectFill
    collectionView!.backgroundView = imageView
    
    // set up add new photo button
    var myX = collectionView!.contentOffset.x + (CGRectGetWidth(collectionView!.bounds)*0.33)
    var myY =  collectionView!.contentOffset.y + (CGRectGetHeight(collectionView!.bounds)*0.75)
    let button = UIButton(type: UIButtonType.System)
    button.frame = CGRectMake(myX,myY,10,10)
    button.backgroundColor = nil
    button.setTitle("+", forState: UIControlState.Normal)
    button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    button.addTarget(self, action: "addPhotoButton:", forControlEvents: UIControlEvents.TouchUpInside)
    view.addSubview(button)
    
    // delete circle button
    myX = collectionView!.contentOffset.x + (CGRectGetWidth(collectionView!.bounds)*0.4)
    myY =  collectionView!.contentOffset.y + (CGRectGetHeight(collectionView!.bounds)*0.28)
    let delbutton = UIButton(type: UIButtonType.System)
    delbutton.frame = CGRectMake(myX,myY,collectionView!.bounds.width*0.4,10)
    delbutton.titleLabel?.font = UIFont(name: (delbutton.titleLabel!.font?.fontName)!, size: 10)
    delbutton.backgroundColor = nil
    delbutton.setTitle("Delete This Circle", forState: UIControlState.Normal)
    delbutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    delbutton.addTarget(self, action: "deleteCircleButton:", forControlEvents: UIControlEvents.TouchUpInside)
    view.addSubview(delbutton)
    
    // view circle photos button
    myX = collectionView!.contentOffset.x + (CGRectGetWidth(collectionView!.bounds)*0.4)
    myY =  collectionView!.contentOffset.y + (CGRectGetHeight(collectionView!.bounds)*0.31)
    let picsbutton = UIButton(type: UIButtonType.System)
    picsbutton.frame = CGRectMake(myX,myY,collectionView!.bounds.width*0.4,10)
    picsbutton.titleLabel?.font = UIFont(name: (picsbutton.titleLabel!.font?.fontName)!, size: 10)
    picsbutton.backgroundColor = nil
    picsbutton.setTitle("View Circle Pictures", forState: UIControlState.Normal)
    picsbutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    picsbutton.addTarget(self, action: "viewCirclePics:", forControlEvents: UIControlEvents.TouchUpInside)
    view.addSubview(picsbutton)
    
    // set logo to top of screen
    let logoView = UIImageView(image: UIImage(named: "circleslogo.png"))
    let screenWidth = collectionView!.bounds.width
    var frm: CGRect = logoView.frame
    frm.origin.y = frm.origin.y - 125
    frm.size.width = screenWidth
    logoView.frame = frm
    view.addSubview(logoView)
    
    
    // circle name
    let homeNameLabel = UILabel() as UILabel
    homeNameLabel.text = self.circleName
    homeNameLabel.textColor = UIColor.whiteColor()
    myX = collectionView!.contentOffset.x+(CGRectGetWidth(collectionView!.bounds)*0.4)
    myY =  collectionView!.contentOffset.y + (CGRectGetHeight(collectionView!.bounds)*0.2)
    homeNameLabel.frame = CGRectMake(myX,myY,collectionView!.bounds.width,25)
    view.addSubview(homeNameLabel)
    
    // back circle button
    let backbutton = UIButton(type: UIButtonType.System)
    backbutton.frame = CGRectMake(0,40,100,10)
    backbutton.titleLabel?.font = UIFont(name: (backbutton.titleLabel!.font?.fontName)!, size: 15)
    backbutton.backgroundColor = nil
    backbutton.setTitle("Back", forState: UIControlState.Normal)
    backbutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    backbutton.addTarget(self, action: "goBack:", forControlEvents: UIControlEvents.TouchUpInside)
    view.addSubview(backbutton)
    
    
    images1 = NSBundle.mainBundle().pathsForResourcesOfType("png", inDirectory: "Images")
    
  }
  
  func goBack(sender: UIButton!) {
    self.performSegueWithIdentifier("home", sender: sender)
    
  }
  
  
  func addPhotoButton(sender: UIButton!) {
    
    // user wishes to upload a new photo to circle
    print("add photo button worked correctly in a circle homepage", terminator: "")
    self.performSegueWithIdentifier("newphotosegue", sender: sender)
    
  }
  
  func deleteCircleButton(sender: UIButton!) {
    circleActually.deleteInBackground()
    performSegueWithIdentifier("home", sender: sender)
    let alert = UIAlertView(title: "MyCircles", message: "Deleted circle", delegate:self,cancelButtonTitle: "OK")
    alert.show()
  }
  
  func viewCirclePics(sender: UIButton!) {
    performSegueWithIdentifier("circlePictures", sender: sender)
  }
  
  
}

extension ACircleCollectionViewController { //: UICollectionViewDataSource {
  
  // sets the number of circles to put in collection view = number of members
  override func collectionView(collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
      return circleMembers.count
  }
  
  // sets the circle image to the correct circle color
  override func collectionView(collectionView: UICollectionView,
    cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

      let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier2, forIndexPath: indexPath) as! ACircleCollectionViewCell
      cell.imageName1 = images1![indexPath.row]
      print(indexPath.row)
      
      cell.memberName1.text = circleMembers[indexPath.row] as String
      
      cell.memberName1.textColor = UIColor.darkGrayColor()

      
      return cell
      
  }
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    print("\(indexPath.row)")
    print("\(circleMembers.count)")
    if(indexPath.row == 0) {
      print("yes")
      
      let alert = UIAlertController(title: "Add New Circle Member", message: "Enter Name:", preferredStyle: .Alert)
      alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
        textField.text = ""
      })
      alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
        let textField = alert.textFields![0] as UITextField
        //print("Text field: \(textField.text)")
        let newMem = textField.text! as String
        
        self.circleMembers.append(newMem)
        print("\(self.circleMembers.last)")
        
        let me = PFObject(withoutDataWithClassName: "NewCircle", objectId: self.circleObjectId!)
        me.setObject(self.circleMembers, forKey: "circleMembers")
        
        me.saveInBackgroundWithBlock { (success, error) in
          if (success) {
            _ = Invitation.createInvitationAndStoreForMember("You're invited!", circleCreator: PFUser.currentUser()!.username!, circleId: self.circleObjectId!, circleMember: newMem, circleMembers: self.circleMembers)
          } else {
            // There was a problem, check error.description
          }
        }
        
      }))
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "circlePictures" {
      let picVC = segue.destinationViewController as! CircleImagesTableViewController
      if(circleImages != nil) {
        picVC.circleImagesArray = circleImages!
      } else{
        picVC.circleImagesArray = []
      }
      picVC.circleObjectId = circleObjectId!
    }
    if segue.identifier == "newphotosegue" {
      let viewController = segue.destinationViewController as! AddPhotoViewController
      viewController.circleObjectId = self.circleObjectId!
    }
    if segue.identifier == "home" {
      _ = segue.destinationViewController as! UITabBarController
      
    }
  }
    
}
