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
    var token: String?
    var id: Int?
    
    init(firstName: String, lastName: String, email: String, role: String, password: String, token: String? = nil, id: Int? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.role = role
        self.password = password
        self.token = token
        self.id = id
    }
    
    enum CodingKeys: String, CodingKey {
        case firstName = "firstname"
        case lastName = "lastname"
        case email = "email"
        case role = "role"
        case password = "password"
    }
}
