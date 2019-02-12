//
//  RootSwitch.swift
//  I'll Serve Soup
//
//  Created by Nathanael Youngren on 2/11/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

class RootSwitch {
    
    static func updateVC() {
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: .isLoggedIn)
        let rootVC: UIViewController?
        
        if isLoggedIn {
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "inventoryCVC") as! InventoryCollectionViewController
        } else {
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "logInVC") as! LoginViewController
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
}
