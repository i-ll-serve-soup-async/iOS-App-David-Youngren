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
    
    let baseURL = URL(string: "https://soup-kitchen-backend.herokuapp.com/api")!
    
    let tokenValue = UserDefaults.standard.string(forKey: .token)
    let idValue = UserDefaults.standard.value(forKey: .id)
    
    func getItems(completion: @escaping (Error?) -> Void) {
        let itemsURL = baseURL.appendingPathComponent("items")
        
        guard let token = tokenValue else {
            completion(NSError())
            return
        }
        
        var urlRequest = URLRequest(url: itemsURL)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue(token, forHTTPHeaderField: "authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
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
    
    func loadImages(item: Item, completion: @escaping (Data?) -> Void) {

        guard let urlString = item.imageURL else { return }
        let url = URL(string: urlString)!

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("There was an error retrieving an image: \(error)")
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(data)
            }
        }.resume()
    }
    
    func addItem(name: String, amount: Int, category: Int, unit: String, completion: @escaping (Error?) -> Void) {
        
        let newItem = Item(name: name, amount: amount, categoryID: category, unit: unit)
        print(newItem)

        let itemsURL = baseURL.appendingPathComponent("items")

        var urlRequest = URLRequest(url: itemsURL)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue(tokenValue!, forHTTPHeaderField: "authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        let encoder = JSONEncoder()
        do {
            urlRequest.httpBody = try encoder.encode(newItem)
        } catch {
            print(NSError())
            completion(error)
            return
        }

        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print("There was an error sending data to the server: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }

    func updateItem(item: Item, name: String, amount: Int, category: Int, unit: String, completion: @escaping (Error?) -> Void) {
        
        let updatedItem = ItemPUT(name: name, amount: amount, categoryID: category, unit: unit)
        guard let itemID = item.id else {
            completion(NSError())
            return }
        
        let itemsURL = baseURL.appendingPathComponent("items")
        let idURL = itemsURL.appendingPathComponent("\(itemID)")
        print(idURL)
        var urlRequest = URLRequest(url: idURL)
        urlRequest.httpMethod = "PUT"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue(tokenValue!, forHTTPHeaderField: "authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let encoder = JSONEncoder()
        do {
            urlRequest.httpBody = try encoder.encode(updatedItem)
        } catch {
            print(NSError())
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print("There was an error sending data to the server: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func deleteItem(item: Item, completion: @escaping (Error?) -> Void) {
        guard let itemID = item.id else {
            completion(NSError())
            return }
        
        let itemsURL = baseURL.appendingPathComponent("items")
        let idURL = itemsURL.appendingPathComponent("\(itemID)")
        
        var urlRequest = URLRequest(url: idURL)
        
        urlRequest.httpMethod = "DELETE"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue(tokenValue!, forHTTPHeaderField: "authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print("There was an error deleting data to the server: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
}
