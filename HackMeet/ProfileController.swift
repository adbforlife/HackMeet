//
//  ProfileController.swift
//  HackMeet
//
//  Created by ADB on 5/20/17.
//  Copyright © 2017 ADB. All rights reserved.
//

import UIKit

class ProfileController: UIViewController, UIScrollViewDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var scrollView: UIScrollView!
    var containerView = UIView()
    
    var profileBorder: UIButton!
    var nameTextView: UITextView!
    var emailTextView: UITextView!
    var summaryTextView: UITextView!
    
    let imagePicker =  UIImagePickerController()

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
        
        profileBorder = UIButton(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        profileBorder.layer.borderColor = Header.appColor.cgColor
        profileBorder.layer.borderWidth = 5
        profileBorder.layer.cornerRadius = 10
        profileBorder.addTarget(self, action: #selector(self.picTouched(_:)), for: .touchUpInside)
        containerView.addSubview(profileBorder)
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
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
        makeEditButton(frame: CGRect(x: 340, y: Int(nameTextView.frame.minY)+10, width: 25, height: 25), selector: #selector(self.editName(_:)))
        
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
        makeEditButton(frame: CGRect(x: 340, y: Int(emailTextView.frame.minY)+10, width: 25, height: 25), selector: #selector(self.editEmail(_:)))
        
        summaryTextView = UITextView(frame: CGRect(x: 75/2, y: 130, width: 300, height: 120))
        summaryTextView.delegate = self
        if User.sharedUser.summary == "" {
            summaryTextView.text = "Hello everyone! This is my summary. I will use this space to give a quick introduction about me and my hacking experience."
        } else {
            summaryTextView.text = User.sharedUser.summary
        }
        summaryTextView.font =  UIFont(name:"HelveticaNeue-Light", size: 18)
        summaryTextView.textColor = Header.appColor
        summaryTextView.isScrollEnabled = false
        summaryTextView.isEditable = false
        summaryTextView.isSelectable = false
        summaryTextView.returnKeyType = UIReturnKeyType.done
        summaryTextView.textAlignment = .center
        containerView.addSubview(summaryTextView)
        makeEditButton(frame: CGRect(x: 340, y: Int(summaryTextView.frame.minY)+30, width: 25, height: 25), selector: #selector(self.editSummary(_:)))
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
            textView.isSelectable = false
            textView.isEditable = false
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
    
    func editSummary(_ sender: UIButton) {
        summaryTextView.isSelectable = true
        summaryTextView.isEditable = true
        summaryTextView.becomeFirstResponder()
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
    
    
    
    // Creates a UIAlertController to either take a picture or choose from the gallery
    func picTouched(_ sender: UIButton!) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: "How would you like to set your picture?", preferredStyle: .actionSheet)
        actionSheetController.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in })
        actionSheetController.addAction(addPhotoAction(title: "Take Picture", source: .camera, message: "Sorry, the camera is inaccessible"))
        actionSheetController.addAction(addPhotoAction(title: "Choose From Photos", source: .photoLibrary, message: "Sorry, the photo gallery is inaccessible"))
        
        if User.sharedUser.proPic.image.debugDescription != "nil" {
            actionSheetController.addAction(UIAlertAction(title: "Delete Current Picture", style: .default) { action -> Void in
                User.sharedUser.proPic = UIImageView()
                self.profileBorder.setImage(UIImage(named: "Happy2.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
            })
        }
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    // Sets up the screen that allows the user to pick or take a photo
    func addPhotoAction(title: String, source: UIImagePickerControllerSourceType, message: String) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default) { action -> Void in
            if UIImagePickerController.isSourceTypeAvailable(source) {
                self.imagePicker.sourceType = source
                self.present(self.imagePicker, animated: true,completion: nil)
            } else {
                self.errorMessage(title: message, message: "")
            }
        }
    }
    
    // Displays the appropriate error message to the user when trying to pick/take a photo
    func errorMessage(title: String, message: String){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    // Updates the profile screen based on the chosen picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        User.sharedUser.proPic.image = chosenImage
        profileBorder.setImage(chosenImage, for: .normal)
        profileBorder.imageView?.layer.cornerRadius = profileBorder.layer.cornerRadius
        dismiss(animated:true, completion: nil)
    }
    
    // Dismisses the imagePickerController
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
