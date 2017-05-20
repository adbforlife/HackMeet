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
<<<<<<< Updated upstream
        let filterButton = UIButton(frame: CGRect(x: 0, y: 65, width: 44, height: 44))
        filterButton.backgroundColor = UIColor.red
        filterButton.addTarget(self, action: #selector(self.filterButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(filterButton)
    }
    func filterButtonTapped(_ button: UIButton){
=======
        let filterButton = UIButton(frame: CGRect(x: 0, y: 65, width: 375, height: 40))
        filterButton.backgroundColor = UIColor.red
        filterButton.addTarget(self, action: #selector(self.filterButtonTapped(_:)), for: .touchDown)
        self.view.addSubview(filterButton)
    }
    func filterButtonTapped(_ sender: UIButton) {
>>>>>>> Stashed changes
        self.performSegue(withIdentifier: "toFilter", sender: self)
    }
}
