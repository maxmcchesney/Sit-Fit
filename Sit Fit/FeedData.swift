//
//  FeedData.swift
//  Sit Fit
//
//  Created by Jo Albright on 2/3/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

let _mainData: FeedData = FeedData()

class FeedData: NSObject {
   
    var feedItems: [PFObject] = []
    
    class func mainData() -> FeedData {
        
        return _mainData
        
    }
    
}
