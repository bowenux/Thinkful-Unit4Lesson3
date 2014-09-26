//
//  TableViewController.swift
//  Unit4Lesson3-Photo Search
//
//  Created by Rick Bowen on 9/25/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {

   
    
    let instagramClientID = "1827ab04d8734849914110240d2f5917"
    
   

    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {
        
        
        
        let instagramURLString = "https://api.instagram.com/v1/tags/robot/media/recent?client_id=" + instagramClientID
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.GET( instagramURLString,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                //println("JSON: " + responseObject.description)
                
                if let dataArray = responseObject.valueForKey("data") as? [AnyObject] {
                    
                    //self.scrollView.contentSize = CGSizeMake(320, CGFloat(320 * dataArray.count))
                    
                    for var i = 0; i < dataArray.count; i++ {
                        
                        let dataObject: AnyObject = dataArray[i]
                        
                        if let imageURLString = dataObject.valueForKeyPath("images.standard_resolution.url") as? String {
                            //println("image " + String(i) + " URL is " + imageURLString)
                            
                            let imageView = UIImageView(frame: CGRectMake(0, CGFloat(320*i), 320, 320))
                          //  self.scrollView.addSubview(imageView)
                            imageView.setImageWithURL( NSURL(string: imageURLString))
                            
                            
                        }
                    }
                }
                
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
        
        
        
        
    /*
        
        let fromContact = listOfContacts[sourceIndexPath.row]
        listOfContacts.removeAtIndex(sourceIndexPath.row)
        listOfContacts.insert(fromContact, atIndex: destinationIndexPath.row)
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //    self.searchBar.delegate = self;
        
   //     searchInstagramByHashtag("cars")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}