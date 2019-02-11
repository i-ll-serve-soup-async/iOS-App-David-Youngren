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
    
    func fetchUser(completion: @escaping (Error?) -> Void) {

        let staffURL = baseURL.appendingPathComponent("staff")
        let idURL = staffURL.appendingPathComponent(":id")
        var urlRequest = URLRequest(url: idURL)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("Bearer: token", forHTTPHeaderField: "Authorization")
        
        

    }
    
}
