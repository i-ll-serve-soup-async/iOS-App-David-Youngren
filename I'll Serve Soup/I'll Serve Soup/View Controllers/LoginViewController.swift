//
//  LoginViewController.swift
//  I'll Serve Soup
//
//  Created by Nathanael Youngren on 2/11/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func forgotPasswordButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text,
        let password = passwordTextField.text else { return }
        
        if username.isEmpty || password.isEmpty {
            self.displayAlert(title: "Login Error", message: "Please complete the email and password fields to log in.")
            return
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        userController.runLogIn(email: username, password: password) { (error) in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                    self.displayAlert(title: "Login Error", message: "There was an error retrieving data from the server. Please make sure your email and password are correct and try again.")
                }
                return
            }
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                self.performSegue(withIdentifier: "FinishLogIn", sender: self)
            }
        }
    }
    
    private func displayAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(alertAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    let userController = UserController()

}
