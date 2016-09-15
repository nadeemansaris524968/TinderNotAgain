//
//  SwipingViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Nadeem Ansari on 9/15/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit
import ParseFacebookUtilsV4

class SwipingViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var infoLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let query = PFUser.query()!
        
        var interestedIn = "male"
        
        if (PFUser.currentUser()?["interestedInWomen"])! as! Bool == true {
            interestedIn = "female"
        }
        
        var isFemale = true
        
        if (PFUser.currentUser()?["gender"])! as! String == "male" {
            isFemale = false
        }
        
        query.whereKey("gender", equalTo: interestedIn)
        query.whereKey("interestedInWomen", equalTo: isFemale)
        query.limit = 1
        
        query.findObjectsInBackgroundWithBlock({ (objects, error) in
            
            print("Query")
            
            if error != nil {
                print(error)
            }
            else if let objects = objects as [PFObject]!{
                
                print(objects.count)
                
                for object in objects {
                    
                    let imageFile = object["image"] as! PFFile
                    
                    imageFile.getDataInBackgroundWithBlock({ (imageData, error) in
                        
                        if error != nil {
                            print(error)
                        }
                        else {
                            
                            if let data = imageData {
                                
                                self.userImage.image = UIImage(data: data)
                                
                            }
                        }
                        
                    })
                }
            }
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "logOut" {
            PFUser.logOutInBackground()
        }
    }
 

}
