//
//  ViewController.swift
//  HackMeet
//
//  Created by ADB on 5/20/17.
//  Copyright © 2017 ADB. All rights reserved.
//

import UIKit

class SearchController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets up the header, background, and other views
        self.view.backgroundColor = UIColor.white
        let header = Header(title: "Find Teammates")
        self.view.addSubview(header)
    
    }
    
}
