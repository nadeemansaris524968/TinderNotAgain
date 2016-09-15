//
//  SignUpViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Nadeem Ansari on 9/14/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit
import ParseFacebookUtilsV4

class SignUpViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var interestedInWomen: UISwitch!
    
    @IBAction func signUpBTN(sender: AnyObject) {
        
        PFUser.currentUser()?["interestedInWomen"] = interestedInWomen.on
        PFUser.currentUser()?.saveInBackground()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender"])
        
        graphRequest.startWithCompletionHandler { (connection, result, error) in
            
            if error != nil {
                print(error)
            }
            else if let result = result {
                
                PFUser.currentUser()!["gender"] = result["gender"]!
                PFUser.currentUser()!["name"] = result["name"]!
                
                PFUser.currentUser()?.saveInBackground()
                
                let userID = result["id"]! as! String
                let facebookProfilePictureURL = "https://graph.facebook.com/" + userID + "/picture?type=large"
                
                if let fbpicURL = NSURL(string: facebookProfilePictureURL) {
                    
                    if let data = NSData(contentsOfURL: fbpicURL) {
                        
                        self.userImage.image = UIImage(data: data)
                        
                        let imagePNG = UIImagePNGRepresentation(self.userImage.image!)
                        
                        let imageFile:PFFile = PFFile(data: imagePNG!, contentType: "image/png")
                        
                        PFUser.currentUser()?["image"] = imageFile
                        
                        PFUser.currentUser()?.saveInBackground()
                    }
                }
            }
            
        }

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
