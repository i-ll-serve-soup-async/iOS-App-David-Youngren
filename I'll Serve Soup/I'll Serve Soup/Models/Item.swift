//
//  Item.swift
//  I'll Serve Soup
//
//  Created by Nathanael Youngren on 2/11/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

struct Item: Codable {
    var name: String
    var amount: Int
    var categoryID: Int
    var imageURL: String?
    var id: Int?
    var unit: String

    init(name: String, amount: Int, categoryID: Int, imageURL: String? = nil, id: Int? = nil, unit: String) {
        self.name = name
        self.amount = amount
        self.categoryID = categoryID
        self.imageURL = imageURL
        self.id = id
        self.unit = unit
    }
}

struct ItemPUT: Codable {
    var name: String
    var amount: Int
    var categoryID: Int
    var unit: String
}

struct ItemCreated: Codable {
    var itemID: Int
}

struct ItemsResponse: Codable {
    let items: [Item]
}
