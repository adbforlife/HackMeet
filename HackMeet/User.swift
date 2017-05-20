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
    var userId: Int?
    
    func updateName(_ name: String) {
        // prepare json data
        let json: [String: Any] = ["userId": 1, "userChecksum": name]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "http://10.240.81.23:3000/updateProfile")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        
        task.resume()
    }
    
}
