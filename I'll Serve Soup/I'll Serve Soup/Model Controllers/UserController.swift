//
//  UserController.swift
//  I'll Serve Soup
//
//  Created by Nathanael Youngren on 2/11/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

class UserController {
    
    let baseURL = URL(string: "https://soup-kitchen-backend.herokuapp.com/api")!
    
    func createUser(firstName: String, lastName: String, role: String, email: String, password: String, completion: @escaping (Error?) -> Void) {
        let newUser = User(firstName: firstName, lastName: lastName, email: email, role: role, password: password)
        
        let staffURL = baseURL.appendingPathComponent("staff")
        let registerURL = staffURL.appendingPathComponent("register")
        
        var urlRequest = URLRequest(url: registerURL)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        let encoder = JSONEncoder()
        
        do {
            urlRequest.httpBody = try encoder.encode(newUser)
        } catch {
            print("There was an error while posting to the server: \(NSError())")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(UserResponse.self, from: data)
                let token = decodedData.token
                let id = decodedData.id
                self.defaults.set(token, forKey: .token)
                self.defaults.set(id, forKey: .id)
                completion(nil)
            } catch {
                print("There was an error receiving from the server: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    func runLogIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        let userLogIn = UserLogIn(email: email, password: password)
        
        let staffURL = baseURL.appendingPathComponent("staff")
        let loginURL = staffURL.appendingPathComponent("login")
        
        var urlRequest = URLRequest(url: loginURL)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        
        let encoder = JSONEncoder()
        
        do {
            urlRequest.httpBody = try encoder.encode(userLogIn)
        } catch {
            print("There was an error while posting to the server: \(NSError())")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(UserResponse.self, from: data)
                let token = decodedData.token
                let id = decodedData.id
                self.defaults.set(token, forKey: .token)
                self.defaults.set(id, forKey: .id)
                completion(nil)
            } catch {
                print("There was an error retrieving data from the server: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    let defaults = UserDefaults.standard
}
