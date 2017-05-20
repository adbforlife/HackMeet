//
//  Header.swift
//  HackMeet
//
//  Created by Asher Dale on 5/20/17.
//  Copyright © 2017 ADB. All rights reserved.
//

import UIKit

class Header: UIView {
    
    var height = 64
    let width = 375
    static let appColor = UIColor(hexString: "#2eb93c")
    var title: String
    
    // Initializes the object
    init(title: String) {
        self.title = title
        super.init(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        self.backgroundColor = UIColor.white
        
        let headerBottomBorder = UIView(frame: CGRect(x: 0.0, y: 63.5, width: Double(width), height: 0.5))
        headerBottomBorder.backgroundColor = UIColor.lightGray
        self.addSubview(headerBottomBorder)
        
        showTitle()
    }
    
    // Displays the title of the tab
    func showTitle() {
        makeLabel(label: UILabel(), text: title, rect: CGRect(x: self.width/2-75, y: 26, width: 150, height: 30), font: UIFont(name:"HelveticaNeue-Medium", size: 23)!)
    }
    
    // Displays the title text of the tab in the center of the header
    func makeLabel(label: UILabel, text: String, rect: CGRect, font: UIFont) {
        label.frame = rect
        label.text = text
        label.font = font
        label.textColor = Header.appColor
        label.textAlignment = NSTextAlignment.center
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Extension of UIColor to allow for hex color values
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
