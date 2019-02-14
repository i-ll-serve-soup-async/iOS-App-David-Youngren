//
//  SignUpViewController.swift
//  I'll Serve Soup
//
//  Created by Nathanael Youngren on 2/11/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        
        guard let firstName = firstNameTextField.text,
        let lastName = lastNameTextField.text,
        let role = roleTextField.text,
        let email = emailTextField.text,
        let password = passwordTextField.text,
        let passwordCheck = passwordCheckTextField.text else {
            return
        }
        
        if firstName.isEmpty || lastName.isEmpty || role.isEmpty || email.isEmpty || password.isEmpty || passwordCheck.isEmpty {
            displayAlert(title: "Empty Fields", message: "Please fill in all fields.")
            return
        }
        
        if password != passwordCheck {
            displayAlert(title: "Passwords Incorrect", message: "Your passwords don't match")
            return
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        userController.createUser(firstName: firstName, lastName: lastName, role: role, email: email, password: password) { (error) in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                    self.displayAlert(title: "Server Error", message: "There was an error retrieving data from the server. Please try again later.")
                }
                return
            }
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                guard let destinationVC = mainStoryboard.instantiateViewController(withIdentifier: "InventoryCollectionViewController") as? InventoryCollectionViewController else { return }
                self.present(destinationVC, animated: true, completion: nil)
            }
        }
    }
    
    private func displayAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(alertAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func setAppearance() {
        firstNameTextField.font = AppearanceHelper.textFieldFont()
        lastNameTextField.font = AppearanceHelper.textFieldFont()
        roleTextField.font = AppearanceHelper.textFieldFont()
        emailTextField.font = AppearanceHelper.textFieldFont()
        passwordTextField.font = AppearanceHelper.textFieldFont()
        passwordCheckTextField.font = AppearanceHelper.textFieldFont()
        signUpTitle.font = AppearanceHelper.systemFont(size: 35, style: .title1)
        signUpTitle.textColor = AppearanceHelper.darkGreen
        signUpButton.titleLabel?.font = AppearanceHelper.systemFont(size: 25, style: .body)
        signUpButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        signUpButton.backgroundColor = AppearanceHelper.red
        signUpButton.layer.cornerRadius = 8
        signUpButton.tintColor = AppearanceHelper.pink
        signUpTitle.text = "Create Account"
        signUpButton.titleLabel?.text = "Sign Up"
    }
    
    @IBOutlet weak var signUpTitle: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var roleTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    let userController = UserController()

}
