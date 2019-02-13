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
    
    var testItems: [Item] = [
        Item(name: "Bananas", amount: 200, categoryID: 1, id: 1),
        Item(name: "Strawberries", amount: 50, categoryID: 2, id: 2),
        Item(name: "Potatoes", amount: 250, categoryID: 3, id: 3)
    ]
    
    let baseURL = URL(string: "https://soup-kitchen-backend.herokuapp.com/api")!
    
    let tokenValue = UserDefaults.standard.string(forKey: .token)
    let idValue = UserDefaults.standard.value(forKey: .id)
    
    func getItems(completion: @escaping (Error?) -> Void) {
        
        let itemsURL = baseURL.appendingPathComponent("items")
        
        var urlRequest = URLRequest(url: itemsURL)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue("\(String(describing: tokenValue))", forHTTPHeaderField: "authorization")
        print(tokenValue!)
        
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
                let decodedData = try decoder.decode(ItemsResponse.self, from: data)
                let decodedItems = decodedData.items
                self.items = decodedItems
                completion(nil)
            } catch {
                print(error)
                completion(error)
                return
            }
        }.resume()
    }
    
    func addItem(name: String, amount: Int, category: Int, completion: @escaping (Error?) -> Void) {

        var newItem = Item(name: name, amount: amount, categoryID: category)

        let itemsURL = baseURL.appendingPathComponent("items")

        var urlRequest = URLRequest(url: itemsURL)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue("\(String(describing: tokenValue))", forHTTPHeaderField: "authorization")

        let encoder = JSONEncoder()
        do {
            urlRequest.httpBody = try encoder.encode(newItem)
        } catch {
            print(NSError())
            completion(error)
            return
        }

        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print("There was an error sending data to the server: \(error)")
                completion(error)
                return
            }

            guard let data = data else {
                completion(NSError())
                return
            }

            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(Int.self, from: data)
                newItem.id = decodedData
                self.items.append(newItem)
            } catch {
                print("There was an error retrieving data from the server: \(error)")
                completion(error)
                return
            }
        }.resume()
    }

    func updateItem(item: Item, name: String, amount: Int, category: Int, completion: @escaping (Error?) -> Void) {



    }
    
    
}
