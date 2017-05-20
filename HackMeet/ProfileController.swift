//
//  ViewController.swift
//  HackMeet
//
//  Created by ADB on 5/20/17.
//  Copyright © 2017 ADB. All rights reserved.
//

import UIKit

class ProfileController: UIViewController, UIScrollViewDelegate, UITextViewDelegate {
    
    var scrollView: UIScrollView!
    var containerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets up the header, background, and other views
        self.view.backgroundColor = UIColor.white
        let header = Header(title: "Profile")
        self.view.addSubview(header)
        
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 375, height: 555)
        containerView = UIView()
        scrollView.addSubview(containerView)
        self.view.addSubview(scrollView)
        
        let profileBorder = UIView(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        profileBorder.layer.borderColor = Header.appColor.cgColor
        profileBorder.layer.borderWidth = 5
        profileBorder.layer.cornerRadius = 10
        containerView.addSubview(profileBorder)
        
        let nameTextView = UITextView(frame: CGRect(x: 125, y: 11, width: 375, height: 50))
        nameTextView.delegate = self
        nameTextView.text = "Enter name here"
        nameTextView.font =  UIFont(name:"HelveticaNeue-Medium", size: 30)
        nameTextView.textColor = Header.appColor
        nameTextView.isScrollEnabled = false
        nameTextView.returnKeyType = UIReturnKeyType.done
        containerView.addSubview(nameTextView)
    }
    
    // Readjusts the UIScrollView
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(x: 0, y: 64, width: 375, height: 554)
        containerView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
    }
    
    // Called when the user presses "done"
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.view.endEditing(true)
        }
        return true
    }
    
}
