//
//  ViewController.swift
//  Unit4Lesson3-Photo Search
//
//  Created by Rick Bowen on 9/25/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mySpinner: UIActivityIndicatorView!
    
    let instagramClientID = "1827ab04d8734849914110240d2f5917"
    
    func searchInstagramByHashtag(searchString: String) {
        for subview in self.scrollView.subviews {
            subview.removeFromSuperview()
        }
        
        let instagramURLString = "https://api.instagram.com/v1/tags/" + searchString + "/media/recent?client_id=" + instagramClientID
        
        let manager = AFHTTPRequestOperationManager()
        
        self.mySpinner.startAnimating()
        
        manager.GET( instagramURLString,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                //println("JSON: " + responseObject.description)
                
                if let dataArray = responseObject.valueForKey("data") as? [AnyObject] {
                    self.scrollView.contentSize = CGSizeMake(320, CGFloat(320 * dataArray.count))
                    self.mySpinner.stopAnimating()
                    
                    for var i = 0; i < dataArray.count; i++ {
                        
                        let dataObject: AnyObject = dataArray[i]
                        
                        if let imageURLString = dataObject.valueForKeyPath("images.standard_resolution.url") as? String {
                            //println("image " + String(i) + " URL is " + imageURLString)
                            
                            let imageView = UIImageView(frame: CGRectMake(0, CGFloat(320*i), 320, 320))
                            self.scrollView.addSubview(imageView)
                            imageView.setImageWithURL( NSURL(string: imageURLString))
                            
                            
                        }
                    }
                }
                
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        searchInstagramByHashtag(searchBar.text)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self;
        
        searchInstagramByHashtag("cars")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

