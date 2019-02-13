//
//  Item.swift
//  I'll Serve Soup
//
//  Created by Nathanael Youngren on 2/11/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

struct Item: Codable {
    let name: String
    let amount: Int
    let categoryID: Int
    let imageURL: String?
    var id: Int?

    init(name: String, amount: Int, categoryID: Int, imageURL: String? = nil, id: Int? = nil) {
        self.name = name
        self.amount = amount
        self.categoryID = categoryID
        self.imageURL = imageURL
        self.id = id
    }
}

struct ItemsResponse: Codable {
    let items: [Item]
}
