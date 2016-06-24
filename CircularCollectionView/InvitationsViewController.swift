
import UIKit
import Parse
import Bolts

class InvitationsViewController: UIViewController {
  
    
    @IBOutlet weak var invitationView1: UIView!
    @IBOutlet weak var invitationView2: UIView!
    @IBOutlet weak var invitationView3: UIView!
    @IBOutlet weak var invitationView4: UIView!
    
    @IBOutlet weak var invitedCircleName1: UILabel!
    
    @IBOutlet weak var invitedCircleName2: UILabel!
    
    @IBOutlet weak var invitedCircleName3: UILabel!
  
    @IBOutlet weak var invitedCircleName4: UILabel!
    
    @IBOutlet weak var invitedByName1: UILabel!
    
    
    @IBOutlet weak var invitedByName2: UILabel!
    
    
    @IBOutlet weak var invitedByName3: UILabel!
    

    @IBOutlet weak var invitedByName4: UILabel!
    
    @IBOutlet weak var circleMembers1: UILabel!
    
    @IBOutlet weak var circlesMembers2: UILabel!
    
    @IBOutlet weak var circlesMembers3: UILabel!
    
    @IBOutlet weak var circlesMembers4: UILabel!
    
    
    
    
  let circleNames: [String] = ["HS Friends","Kerney Family","Bowman Family","Cousins","College Friends","Test 6","Test 7","Test 8","Test 9","Test 10","Test 11","Test 12","Test 13","Test 14","Test 15"]
  let circleInvitee: [String] = ["Mackenzie Gillund","Kayla Kerney","Will Bowman","Dana Sprague","Kate McKenzie","Corbin Jensen 6","Mattie Stearns 7","Test Person 8","Test Person 9","Test Person 10","Test Person 11","Test Person 12","Test Person 13","Test Person 14","Test Person 15"]
  let circleMembers: [String] = ["Circle 1 Members","Circle 2 Members","Circle 3 Members","Circle 4 Members","Circle 5 Members","Circle 6 Members","Circle 7 Members","Circle 8 Members","Circle 9 Members","Circle 10 Members","Circle 11 Members","Circle 12 Members","Circle 13 Members","Circle 14 Members","Circle 15 Members"]
  
  var currUser : PFUser!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "random_grey_variations.png")!)
    
    // only display invitations when invitation stack is not empty
    
    invitationView1.backgroundColor = UIColor.lightGrayColor()
    invitationView1.layer.borderWidth = 1
    invitationView1.layer.borderColor = UIColor.whiteColor().CGColor
    
    invitationView2.backgroundColor = UIColor.lightGrayColor()
    invitationView2.layer.borderWidth = 1
    invitationView2.layer.borderColor = UIColor.whiteColor().CGColor
    
    invitationView3.backgroundColor = UIColor.lightGrayColor()
    invitationView3.layer.borderWidth = 1
    invitationView3.layer.borderColor = UIColor.whiteColor().CGColor
    
    invitationView4.backgroundColor = UIColor.lightGrayColor()
    invitationView4.layer.borderWidth = 1
    invitationView4.layer.borderColor = UIColor.whiteColor().CGColor
    
    
    invitedCircleName1.text = "Circle Name: \(circleNames[0])"
    invitedByName1.text = "Invited By: \(circleInvitee[0])"
    // create drop down arrow to view all current members in the circle
    circleMembers1.text = "Circle Memebrs: \(circleMembers[0])"
    
    invitedCircleName2.text = "Circle Name: \(circleNames[1])"
    invitedByName2.text = "Invited By: \(circleInvitee[1])"
    // create drop down arrow to view all current members in the circle
    circlesMembers2.text = "Circle Memebrs: \(circleMembers[1])"
    
    invitedCircleName3.text = "Circle Name: \(circleNames[2])"
    invitedByName3.text = "Invited By: \(circleInvitee[2])"
    // create drop down arrow to view all current members in the circle
    circlesMembers3.text = "Circle Memebrs: \(circleMembers[2])"
    
    invitedCircleName4.text = "Circle Name: \(circleNames[3])"
    invitedByName1.text = "Invited By: \(circleInvitee[3])"
    // create drop down arrow to view all current members in the circle
    circlesMembers4.text = "Circle Memebrs: \(circleMembers[3])"
    
    
    
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func acceptedInviteButton(sender: AnyObject) {
    
    // currUser = PFUser.currentUser()
    // accepted = pop invite that was pushed from the stack
    // push "accepted" circle onto the users.userCircles.append(accepted)
    // display an accepted message and delete invitation from view controller
    
    
    
  }
  @IBAction func declineInviteButton(sender: AnyObject) {
    // pop invite from the stack
    // delete invitation from view controller
    
    
  }
  
  
}
