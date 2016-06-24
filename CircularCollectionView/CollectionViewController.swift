

import UIKit
import Parse
import Bolts


let reuseIdentifier = "Cell" // global identifer of custom created cell from CollectionViewController.xib

class CollectionViewController: UICollectionViewController {
  let images: [String] = NSBundle.mainBundle().pathsForResourcesOfType("png", inDirectory: "Images")
  var circles: [String] = []

  var circleNames: [String] = []
  var circleSelected : Int = 0
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBarHidden = false
    let currentUser = PFUser.currentUser()
    do {
      try currentUser!.fetch()
    } catch {
      print("error")
    }
    //    try currentUser!.fetch()
    //      throw ErrorType
    print(currentUser!)
    circleNames.removeAll()
    circleNames = ["Demo Circle"]
    circles.removeAll()
   
    circles.appendContentsOf(currentUser!.objectForKey("circles") as! [String])
    for circle in circles {      
      let query2 = PFQuery.init(className: "NewCircle")
      query2.getObjectInBackgroundWithId(circle) {
        (circle: PFObject?, error: NSError?) -> Void in
        if error == nil && circle != nil {
          let circleActually = circle as! NewCircle
          let circleName = circleActually.objectForKey("circleName") as! String
          self.circleNames.append(circleName)
          self.collectionView?.reloadData()
          }
        else {
          print(error, terminator: "")
        }
      }
    }
    
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // register cell classes
    collectionView!.registerNib(UINib(nibName: "CircularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    
    // set background .png image view
    let imageView = UIImageView(image: UIImage(named: "random_grey_variations.png"))
    imageView.contentMode = UIViewContentMode.ScaleAspectFill
    collectionView!.backgroundView = imageView
    
    // set up add new photo button
    var myX = collectionView!.contentOffset.x + (CGRectGetWidth(collectionView!.bounds)*0.38)
    var myY =  collectionView!.contentOffset.y + (CGRectGetHeight(collectionView!.bounds)*0.2)
    
    // set up add new circle button
    myX = collectionView!.contentOffset.x + (CGRectGetWidth(collectionView!.bounds)*0.33)
    myY =  collectionView!.contentOffset.y + (CGRectGetHeight(collectionView!.bounds)*0.75)
    let button = UIButton(type: UIButtonType.System)
    button.frame = CGRectMake(myX,myY,25,25)
    button.backgroundColor = nil
    button.setTitle("+", forState: UIControlState.Normal)
    button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
    view.addSubview(button)
    
    myX = collectionView!.contentOffset.x + (CGRectGetWidth(collectionView!.bounds)*0.38)
    myY =  collectionView!.contentOffset.y + (CGRectGetHeight(collectionView!.bounds)*0.2)
    let logoutButton = UIButton(type: UIButtonType.System)
    logoutButton.frame = CGRectMake(myX,myY,100,25)
    logoutButton.backgroundColor = nil
    logoutButton.setTitle("Logout", forState: UIControlState.Normal)
    logoutButton.setTitleColor(UIColor(red: 0/255, green: 230/255, blue: 234/255, alpha: 1.0), forState: UIControlState.Normal)
    logoutButton.addTarget(self, action: "addPhotoButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
    view.addSubview(logoutButton)
    
    // set logo to top of screen
    let logoView = UIImageView(image: UIImage(named: "circleslogo.png"))
    let screenWidth = collectionView!.bounds.width
    var frm: CGRect = logoView.frame
    frm.origin.y = frm.origin.y - 125
    frm.size.width = screenWidth
    logoView.frame = frm
    view.addSubview(logoView)
    
    
  }
  func buttonAction(sender: UIButton!) {
    // user wishes to create a new circle
    print("button worked correctly", terminator: "")
    self.performSegueWithIdentifier("newCircle", sender: nil)
    
  }
  func addPhotoButtonAction(sender: UIButton!) {
    PFUser.logOutInBackgroundWithBlock({ (error: NSError?) -> Void in
      if error == nil {
        self.performSegueWithIdentifier("backToLogin", sender: self)
      }
    })
    
  }
}

extension CollectionViewController { //: UICollectionViewDataSource {
  
  // sets the number of circles to put in collection view = number of user's circle groups
  override func collectionView(collectionView: UICollectionView,
    numberOfItemsInSection section: Int) -> Int {
      
      return circleNames.count
  }
  
  // sets the circle image to the correct circle color
  override func collectionView(collectionView: UICollectionView,
    cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CircularCollectionViewCell
      
      cell.imageName = images[indexPath.row]
      cell.imageLabel.text = circleNames[indexPath.row]
      cell.imageLabel.textColor = UIColor.darkGrayColor()

      return cell
      
  }
  
  // specific circle was selected -> segue to that circle's homepage
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    print("circle number \(indexPath.row + 1)", terminator: "")
    circleSelected = indexPath.row
    
//    self.performSegueWithIdentifier("acirclesegue", sender: nil)
    self.performSegueWithIdentifier("tocirclehome", sender: nil)
  }
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if(segue.identifier == "tocirclehome") {
        let viewController = segue.destinationViewController as! ACircleCollectionViewController
        viewController.circleName = circleNames[circleSelected]
        viewController.circleObjectId = circles[circleSelected]
        print("circleObjectId in Circle Home Page: \(circles[circleSelected])\n")
      }
      if(segue.identifier == "newCircle") {
        _ = segue.destinationViewController as! CreateCircleViewController
      }
    }
  }
