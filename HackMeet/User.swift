//
//  User.swift
//  HackMeet
//
//  Created by Asher Dale on 5/20/17.
//  Copyright © 2017 ADB. All rights reserved.
//

class User {
    
    var name = ""
    var email = ""
    var summary = ""
    var numHacks = 0
    
    static var sharedUser = User()
    private init() {}
}
