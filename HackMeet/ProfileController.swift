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
    
    var nameTextView: UITextView!
    var emailTextView: UITextView!

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
        
        let profileBorder = UIButton(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        profileBorder.layer.borderColor = Header.appColor.cgColor
        profileBorder.layer.borderWidth = 5
        profileBorder.layer.cornerRadius = 10
        containerView.addSubview(profileBorder)
        
        let proPic = UIImageView(image: UIImage(named: "ProPic.png")?.withRenderingMode(.alwaysTemplate))
        proPic.tintColor = Header.appColor
        proPic.frame = CGRect(x: 25, y: 25, width: 50, height: 50)
        profileBorder.addSubview(proPic)
        
        nameTextView = UITextView(frame: CGRect(x: 125, y: 20, width: 300, height: 50))
        nameTextView.delegate = self
        if User.sharedUser.name == "" {
            nameTextView.text = "Name"
        } else {
            nameTextView.text = User.sharedUser.name
        }
        nameTextView.font =  UIFont(name:"HelveticaNeue-Medium", size: 30)
        nameTextView.textColor = Header.appColor
        nameTextView.isScrollEnabled = false
        nameTextView.isEditable = false
        nameTextView.isSelectable = false
        nameTextView.returnKeyType = UIReturnKeyType.done
        containerView.addSubview(nameTextView)
        makeEditButton(frame: CGRect(x: 330, y: Int(nameTextView.frame.minY)+10, width: 25, height: 25), selector: #selector(self.editName(_:)))
        
        emailTextView = UITextView(frame: CGRect(x: 125, y: 65, width: 300, height: 40))
        emailTextView.delegate = self
        if User.sharedUser.email == "" {
            emailTextView.text = "example@gmail.com"
        } else {
            emailTextView.text = User.sharedUser.email
        }
        emailTextView.font =  UIFont(name:"HelveticaNeue-Light", size: 20)
        emailTextView.textColor = Header.appColor
        emailTextView.isScrollEnabled = false
        emailTextView.isEditable = false
        emailTextView.isSelectable = false
        emailTextView.keyboardType = .emailAddress
        emailTextView.autocapitalizationType = .none
        emailTextView.returnKeyType = UIReturnKeyType.done
        containerView.addSubview(emailTextView)
        makeEditButton(frame: CGRect(x: 330, y: Int(emailTextView.frame.minY)+10, width: 25, height: 25), selector: #selector(self.editEmail(_:)))
    }
    
    // Readjusts the UIScrollView
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(x: 0, y: 64, width: 375, height: 554)
        containerView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
    }
    
    // Called when the user presses a key on the keyboard
    func textViewDidChange(_ textView: UITextView) {
        if textView == nameTextView && textView.text.characters.count > 9 {
            textView.text.remove(at: textView.text.index(before: textView.text.endIndex))
        }
    }
    
    // Called when the user presses "done"
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.view.endEditing(true)
            nameTextView.isSelectable = false
            nameTextView.isEditable = false
        }
        return true
    }
    
    func makeEditButton(frame: CGRect, selector: Selector) {
        let editButton = UIButton(frame: frame)
        editButton.layer.cornerRadius = editButton.bounds.size.width/2
        editButton.setImage(UIImage(named: "Edit.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        editButton.tintColor = Header.appColor
        editButton.addTarget(self, action: selector, for: .touchUpInside)
        containerView.addSubview(editButton)
    }
    
    func editName(_ sender: UIButton) {
        nameTextView.isSelectable = true
        nameTextView.isEditable = true
        nameTextView.becomeFirstResponder()
    }
    
    func editEmail(_ sender: UIButton) {
        emailTextView.isSelectable = true
        emailTextView.isEditable = true
        emailTextView.becomeFirstResponder()
    }
    
    // Displays the title text of the tab in the center of the header
    func makeLabel(text: String, rect: CGRect, font: UIFont) -> UILabel {
        let label = UILabel(frame: rect)
        label.text = text
        label.font = font
        label.textColor = Header.appColor
        label.textAlignment = NSTextAlignment.center
        return label
    }
    
}
