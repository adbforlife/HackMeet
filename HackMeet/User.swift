//
//  User.swift
//  HackMeet
//
//  Created by Asher Dale on 5/20/17.
//  Copyright © 2017 ADB. All rights reserved.
//

import UIKit

class User {
    
    var name = ""
    var email = ""
    var numHackathons = 0
    
    static var sharedUser = User()
    private init() { }
    
}
