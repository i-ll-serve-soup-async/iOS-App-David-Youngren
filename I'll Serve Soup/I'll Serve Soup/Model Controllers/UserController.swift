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
        
//        let jsonURL = registerURL.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: registerURL)
        urlRequest.httpMethod = "POST"
        
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
            print(data)
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(UserResponse.self, from: data)
                let token = decodedData.token
                print(token)
                let id = decodedData.id
                let defaults = UserDefaults.standard
                defaults.set(token, forKey: .token)
                defaults.set(id, forKey: .id)
                completion(nil)
            } catch {
                print("There was an error receiving from the server: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
//    func fetchUser(completion: @escaping (Error?) -> Void) {
//
//        let staffURL = baseURL.appendingPathComponent("staff")
//
//        guard let id = UserDefaults.standard.string(forKey: .id) else { return }
//
//        let idURL = staffURL.appendingPathComponent(":\(id)")
//
//        URLSession.shared.dataTask(with: idURL) { (data, response, error) in
//            if let error = error {
//                print("There was an error fetching user information: error")
//                completion(nil)
//                return
//            }
//
//            guard let data = data else {
//                print("There was an error retrieving data.")
//                completion(nil)
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let decodedUser = try decoder.decode([User].self, from: data)
//                self.user = decodedUser.map({  })
//                completion(nil)
//            } catch {
//                print(error)
//                completion(error)
//                return
//            }
//        }.resume()
//    }
    
    
}
