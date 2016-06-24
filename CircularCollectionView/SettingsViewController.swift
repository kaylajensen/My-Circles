
import UIKit
import Parse
import Bolts

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UIAlertViewDelegate {
  
  
  @IBOutlet weak var profilePhoto: UIImageView!
  @IBOutlet weak var currentUserName: UITextField!
  @IBOutlet weak var currentUserEmail: UITextField!
  
  @IBAction func changeProPicButton(sender: AnyObject) {
    // load UIPickerView similarly to ViewController file
    let photoPicker = UIImagePickerController()
    photoPicker.delegate = self
    photoPicker.sourceType = .PhotoLibrary
    self.presentViewController(photoPicker, animated: true, completion: nil)
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    
    profilePhoto.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    self.dismissViewControllerAnimated(false, completion: nil)
  }
  
  
  
  @IBAction func saveChangesButton(sender: AnyObject) {
    
    let currentUser = PFUser.currentUser()
    if currentUser != nil {
      currentUser?.setObject(currentUserName.text!, forKey: "username")
      
      let newPic = profilePhoto.image
      let photoFile = PFFile(data: UIImageJPEGRepresentation(newPic!, 1.0)!)
      currentUser!.setObject(photoFile!, forKey: "profilePic")
      currentUser!.saveInBackgroundWithBlock {
        (succeeded: Bool, error: NSError?) -> Void in
        if let _ = error { } else {
          print("successfully changed profile picture")
          let alert = UIAlertView(title: "MyCircles", message: "Looking good in the new pic!", delegate:self,cancelButtonTitle: "OK")
          alert.show()
          
        }
      }
    }
  }
  
  
  @IBAction func resetPasswordPressed(sender: AnyObject) {
    
    let currentUser = PFUser.currentUser()
    
    if currentUser != nil {
      let email = currentUser?.objectForKey("email") as! String
      let userInput = currentUserEmail.text
      if (email == userInput) {
        // send them the reset password email
        PFUser.requestPasswordResetForEmailInBackground(email)
        let alert = UIAlertView(title: "MyCircles Settings", message: "Check your email for Password Reset instructions!", delegate:self,cancelButtonTitle: "OK")
        alert.show()
        currentUserEmail.text = nil
      }
      else {
        // alert that the email does not match the username records
        let alert = UIAlertView(title: "MyCircles Settings", message: "This email does not match the current user. Try again.", delegate:self,cancelButtonTitle: "OK")
        alert.show()
        currentUserEmail.text = nil
      }
    }
    else {
      // Show the signup or login screen
      performSegueWithIdentifier("none", sender: nil)
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "random_grey_variations.png")!)
    
    let currentUser = PFUser.currentUser()
    if currentUser != nil {
      currentUserName.text = currentUser?.objectForKey("username") as? String
      profilePhoto.layer.borderWidth = 0.25
      profilePhoto.layer.borderColor = UIColor.whiteColor().CGColor
      
      if(currentUser?.objectForKey("profilePic") != nil) {
        if let userPicture = PFUser.currentUser()?["profilePic"] as? PFFile {
          userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
            if (error == nil) {
              let image = UIImage(data: imageData!)
              self.profilePhoto.image = image
            }
          }
        }
      } else {
        let defaultPic = UIImage(named: "defaultuserpic.png")
        let photoFile = PFFile(data: UIImageJPEGRepresentation(defaultPic!, 1.0)!)
        currentUser?.setObject(photoFile!, forKey: "profilePic")
        currentUser?.saveInBackgroundWithBlock {
          (succeeded: Bool, error: NSError?) -> Void in
          if let _ = error { } else {
            print("successfully saved default profile picture")
            self.profilePhoto.image = defaultPic
          }
        }
      }
    } else {
      // Show the signup or login screen
      performSegueWithIdentifier("none", sender: nil)
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    if (segue.identifier == "none") {
      _ = segue.destinationViewController as! LoginViewController
    }
    
  }
  
}
