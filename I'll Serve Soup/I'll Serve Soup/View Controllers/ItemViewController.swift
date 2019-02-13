//
//  ItemViewController.swift
//  I'll Serve Soup
//
//  Created by Nathanael Youngren on 2/11/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return units.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return units.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return units[row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "UnwindFromItem", sender: self)
    }
    
    func updateViews() {
        if let item = item {
            itemNameTextField.text = item.name.capitalized
            categoryTextField.text = String(item.categoryID)
            amountTextField.text = String(item.amount)
            navigationItem.title = "Edit \(item.name.capitalized)"
        } else {
            itemNameTextField.text = ""
            categoryTextField.text = ""
            amountTextField.text = ""
            navigationItem.title = "Add Item"
        }
    }
    
    func setAppearance() {
        
    }
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    var item: Item?
    let units = ["lbs.", "oz."]
    
}
