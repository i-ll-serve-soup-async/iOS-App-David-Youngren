//
//  User.swift
//  I'll Serve Soup
//
//  Created by Nathanael Youngren on 2/11/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

struct User: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var role: String
    var password: String
    
    init(firstName: String, lastName: String, email: String, role: String, password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.role = role
        self.password = password
    }
    
    enum CodingKeys: String, CodingKey {
        case firstName = "firstname"
        case lastName = "lastname"
        case email = "email"
        case role = "role"
        case password = "password"
    }
}

struct UserLogIn: Codable {
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

struct UserResponse: Codable {
    var token: String
    var id: Int
    var email: String
}
