//
//  ItemController.swift
//  I'll Serve Soup
//
//  Created by Nathanael Youngren on 2/11/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

class ItemController {
    
    var items: [Item] = []
    
//    let testItems: [Item] = [
//        Item(name: "carrots", amount: 200, unit: "lbs", imageURL: "url", categoryID: 2),
//        Item(name: "bananas", amount: 200, unit: "lbs", imageURL: "url", categoryID: 2),
//        Item(name: "yogurt", amount: 150, unit: "lbs", imageURL: "url", categoryID: 2),
//                             ]
    
    let baseURL = URL(string: "https://soup-kitchen-backend.herokuapp.com/api")!
    
    let tokenValue = UserDefaults.standard.string(forKey: .token)
    let idValue = UserDefaults.standard.value(forKey: .id)
    
    func getItems(completion: @escaping (Error?) -> Void) {
        
        let itemsURL = baseURL.appendingPathComponent("items")
        
        var urlRequest = URLRequest(url: itemsURL)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue("\(String(describing: tokenValue))", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print("There was sending the server request: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode([Item].self, from: data)
                self.items = decodedData
                completion(nil)
            } catch {
                print("There was an retrieving data from the server: \(NSError())")
                completion(error)
                return
            }
        }
    }
}
