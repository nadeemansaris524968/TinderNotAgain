/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Bolts
import FBSDKCoreKit
import FBSDKLoginKit
import ParseFacebookUtilsV4
import Parse

class ViewController: UIViewController {

    @IBAction func signInBTN(sender: AnyObject) {
        
        let permissions = ["public_profile"]
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            if let error = error {
                print(error)
            } else {
                if let user = user {
                    
                    if let interestedInWomen = user["interestedInWomen"] {
                        
                        self.performSegueWithIdentifier("logUserIn", sender: self)
                    }
                    else {
                        
                        self.performSegueWithIdentifier("showSignUpScreen", sender: self)
                    }
                }
            }
        } // end block
        print(PFUser.currentUser()?.objectId)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        if PFUser.currentUser() != nil && PFUser.currentUser()?.objectId != nil {
            
            if let interestedInWomen = PFUser.currentUser()?["interestedInWomen"] {
            
                performSegueWithIdentifier("logUserIn", sender: self)
            }
            else {
                
                self.performSegueWithIdentifier("showSignUpScreen", sender: self)
            }
        }
        
    }
    
}
