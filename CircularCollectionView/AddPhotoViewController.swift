
import UIKit
import Parse
import Bolts

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UIAlertViewDelegate {
    
    
    @IBOutlet weak var imageName: UITextField!
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var uploadButtonLooks: UIButton!
    @IBOutlet weak var postButton: UIButton!
  
    //new
    var circleObjectId = ""
    var newPhoto : PhotoClass = PhotoClass()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      
      self.view.backgroundColor = UIColor(patternImage: UIImage(named: "random_grey_variations.png")!)
      
      displayImage.layer.borderWidth = 0.75
      displayImage.layer.borderColor = UIColor.whiteColor().CGColor
      displayImage.layer.cornerRadius = 100
      displayImage.clipsToBounds = true
      
      imageName.layer.cornerRadius = 20
      imageName.layer.borderWidth = 0.25
      imageName.layer.borderColor = UIColor.grayColor().CGColor
      
      uploadButtonLooks.layer.cornerRadius = 18
      uploadButtonLooks.layer.shadowColor = UIColor.grayColor().CGColor
      uploadButtonLooks.layer.shadowOpacity = 0.7
      uploadButtonLooks.layer.shadowRadius = 3
      uploadButtonLooks.layer.shadowOffset = CGSizeMake(3.0, 3.0)
      
      postButton.layer.cornerRadius = 22
      postButton.layer.shadowColor = UIColor.grayColor().CGColor
      postButton.layer.shadowOpacity = 0.7
      postButton.layer.shadowRadius = 3
      postButton.layer.shadowOffset = CGSizeMake(3.0, 3.0)
      
      
      
      
    }
  @IBAction func backgroundTapped(sender: AnyObject) {
    self.imageName.resignFirstResponder()
  }
    
    @IBAction func postButtonClicked(sender: AnyObject) {
      
      var myBool = false
      // ADD NEW PHOTO TO PARSE
      
      if((displayImage.image != nil) && (!imageName.text!.isEmpty)) {
        
        // save photo to parse
        let newPhoto : PhotoClass = PhotoClass()
        newPhoto.savePostedImaged(displayImage.image!, photoCaption: imageName.text!, photoName: "newPic")
        
        // display success alert
        let alert = UIAlertView(title: "MyCircles", message: "Successfully posted photo!", delegate:self,cancelButtonTitle: "Done")
        
        if(circleObjectId != "") {
          let query = PFQuery(className: "NewCircle")
          query.getObjectInBackgroundWithId(self.circleObjectId) {(circle: PFObject?, error: NSError?) -> Void in
            if error == nil && circle != nil {
              let photoData = UIImageJPEGRepresentation(self.displayImage.image!, 0.5)
              let photoFile = PFFile(data: photoData!)
              let circleObject = circle as! NewCircle
              circleObject.addObject(photoFile!, forKey:"circlePhotos")
              circle?.saveInBackground()
            } else {
              print(error, terminator: "")
            }
          }
        }
        alert.show()
        myBool = true
        
      }
      else {
        // display error alert
        let alert = UIAlertView(title: "MyCircles", message: "Please enter remaining photo information!", delegate:self,cancelButtonTitle: "OK")
        alert.show()
        myBool = false
      }
      if(myBool == true) {
        performSegueWithIdentifier("homesegue", sender: sender)
      }
    }
    
    @IBAction func openPhotoLibrary(sender: AnyObject) {
      let photoPicker = UIImagePickerController()
      photoPicker.delegate = self
      photoPicker.sourceType = .PhotoLibrary
      self.presentViewController(photoPicker, animated: true, completion: nil)
      
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
      
      displayImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
      self.dismissViewControllerAnimated(false, completion: nil)
    }
  


}
