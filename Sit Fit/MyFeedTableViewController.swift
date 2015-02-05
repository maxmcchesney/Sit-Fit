//
//  MyFeedTableViewController.swift
//  Sit Fit
//
//  Created by Jo Albright on 2/3/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class MyFeedTableViewController: FeedTableViewController {
    
    override func refreshFeed() {
        
        FeedData.mainData().refreshMyFeedItems { () -> () in
            
            self.tableView.reloadData()
            
        }
        
    }

}
