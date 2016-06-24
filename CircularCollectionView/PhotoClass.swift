
import Parse
import Bolts
import UIKit


class PhotoClass {
  
  func savePostedImaged(photo : UIImage, photoCaption : String, photoName : String) {
    
    // save UIImage to PFFile
    let photoData = UIImageJPEGRepresentation(photo, 0.5)
    let photoFile = PFFile(name: photoName, data: photoData!)
    
    var circlePhoto : PFObject!
    circlePhoto = PFObject(className: "PhotoClass")
    circlePhoto.setValue(photoName, forKey: "photoName")
    circlePhoto.setValue(photoCaption, forKey: "photoCaption")
    circlePhoto.setValue(photoFile, forKey: "photoFile")
    
    // Also add:
    // Array (tuple) comments = [(Name of photo commenter, "String with comment"),(Another commenter name, "String with another comment")]
    
    circlePhoto.saveInBackgroundWithBlock { (succeeded, error) -> Void in
      if error == nil {
        print("successfully added new photo")
      } else {
        print("\(error)");
      }
    }
  }
  
  
  
  func retrievingPhoto() -> UIImage {
    var image : UIImage?
    let currentUser = PFUser.currentUser()
    if currentUser != nil {
      
      if let userPicture = PFUser.currentUser()?["profilePic"] as? PFFile {
        userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
          if (error == nil) {
            image = UIImage(data: imageData!)
            print("successfully retrieved a photo")
          } else {
            image = nil
            print("unsuccessfully retrieved a photo")
          }
        }
      }
    }
    return image!
  }
}