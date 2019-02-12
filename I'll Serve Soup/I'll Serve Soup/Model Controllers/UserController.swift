//
//  UserController.swift
//  I'll Serve Soup
//
//  Created by Nathanael Youngren on 2/11/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

class UserController {
    
//    var user = User?
    
    let baseURL = URL(string: "https://soup-kitchen-backend.herokuapp.com/api")!
    
    func createUser(firstName: String, lastName: String, role: String, email: String, password: String, completion: @escaping (Error?) -> Void) {
        let newUser = User(firstName: firstName, lastName: lastName, email: email, role: role, password: password)
        
        let registerURL = baseURL.appendingPathComponent("staff/register")
        
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
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            DispatchQueue.main.async {
                completion(nil)
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
