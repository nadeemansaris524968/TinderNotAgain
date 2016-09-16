//
//  ContactsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Nadeem Ansari on 9/16/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit
import ParseFacebookUtilsV4

class ContactsViewController: UITableViewController {
    
    var usernames = [String]()
    
    var images = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let query = PFUser.query()
        
        query?.whereKey("accepted", equalTo: (PFUser.currentUser()?.objectId)!)
        
        query?.whereKey("objectId", containedIn: (PFUser.currentUser()?["accepted"])! as! [String])
        
        query?.findObjectsInBackgroundWithBlock({ (results, error) in
            
            if results != nil {
                
                for result in results as! [PFUser]{
                    
                    self.usernames.append(result.username!)
                    
                    let imageFile = result["image"] as! PFFile
                    
                    imageFile.getDataInBackgroundWithBlock({ (imageData, error) in
                        
                        if error != nil {
                            print(error)
                        }
                        else {
                            
                            if let data = imageData {
                                
                                 self.images.append(UIImage(data: data)!)
                                
                                self.tableView.reloadData()
                                
                            }
                        }
                        
                    })
                }
                
                self.tableView.reloadData()
            }
            
        })
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel?.text = usernames[indexPath.row]
        
        if images.count > indexPath.row {
            cell.imageView?.image = images[indexPath.row]
        }

        return cell
    }
 

}
