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
    var amount: Float
    var unit: String
    var imageURL: String
    var categoryID: Int
}

struct Items: Codable {
    var items: [Item]
}
