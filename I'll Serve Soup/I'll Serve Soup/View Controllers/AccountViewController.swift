//
//  AccountViewController.swift
//  I'll Serve Soup
//
//  Created by Nathanael Youngren on 2/11/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: .isLoggedIn)
    }
    
    @IBAction func resetPasswordTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "UnwindFromAccount", sender: self)
    }
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var roleTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    

}
