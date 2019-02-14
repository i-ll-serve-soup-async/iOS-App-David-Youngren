//
//  ItemViewController.swift
//  I'll Serve Soup
//
//  Created by Nathanael Youngren on 2/11/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
        setAppearance()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = false
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = itemNameTextField.text,
        let category = categoryTextField.text,
        let amount = amountTextField.text,
        let unit = unitTextField.text else {
            print("Text wasn't unwrapped")
            return
        }
        
        guard !name.isEmpty && !category.isEmpty && !amount.isEmpty else {
//            performSegue(withIdentifier: "UnwindFromItem", sender: self)
            print("A field is empty")
            return
        }
        
        var unitValue = ""
        
        if !unit.isEmpty {
            unitValue = unit
        }
        
        guard let amountInt = Int(amount),
        let categoryInt = Int(category) else {
            displayAlert(title: "Wrong Input", message: "It looks like the category or amount isn't a number.")
            return
        }
        
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        guard let item = item else {
            
            itemController.addItem(name: name, amount: amountInt, category: categoryInt, unit: unitValue) { (error) in
                if let error = error {
                    print(error)
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.removeFromSuperview()
                        self.displayAlert(title: "Server Error", message: "There was an error sending data to the server. Please try again later.")
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.removeFromSuperview()
                    self.performSegue(withIdentifier: "UnwindFromItem", sender: self)
                }
            }
            return
        }
        
        itemController.updateItem(item: item, name: name, amount: amountInt, category: categoryInt, unit: unitValue) { (error) in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.removeFromSuperview()
                    self.displayAlert(title: "Server Error", message: "There was an error sending data to the server. Please try again later.")
                }
                return
            }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()
                self.performSegue(withIdentifier: "UnwindFromItem", sender: self)
            }
        }

    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        guard let item = item else { return }
        itemController.deleteItem(item: item) { (error) in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.removeFromSuperview()
                    self.displayAlert(title: "Server Error", message: "There was an error deleting data to the server. Please try again later.")
                }
                return
            }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()
                self.performSegue(withIdentifier: "UnwindFromItem", sender: self)
            }
        }
    }
    
    func updateViews() {
        if let item = item {
            itemNameTextField.text = item.name.capitalized
            categoryTextField.text = String(item.categoryID)
            amountTextField.text = String(item.amount)
            navigationItem.title = "Edit \(item.name.capitalized)"
            deleteButton.setTitle("Delete \(item.name) from inventory.", for: .normal)
            deleteButton.isEnabled = true
        } else {
            itemNameTextField.text = ""
            categoryTextField.text = ""
            amountTextField.text = ""
            navigationItem.title = "Add Item"
            deleteButton.setTitle("", for: .normal)
            deleteButton.isEnabled = false
        }
    }
    
    func setAppearance() {
        itemNameTextField.font = AppearanceHelper.textFieldFont()
        categoryTextField.font = AppearanceHelper.textFieldFont()
        amountTextField.font = AppearanceHelper.textFieldFont()
        unitTextField.font = AppearanceHelper.textFieldFont()
        deleteButton.tintColor = .gray
    }
    
    private func displayAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(alertAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    var item: Item?
    let units = ["lbs.", "oz."]
    let itemController = ItemController()
}
