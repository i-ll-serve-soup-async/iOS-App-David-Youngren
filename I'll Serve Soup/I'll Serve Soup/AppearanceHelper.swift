//
//  AppearanceHelper.swift
//  I'll Serve Soup
//
//  Created by Nathanael Youngren on 2/13/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

enum AppearanceHelper {
    static var pink = UIColor(red: 234/255, green: 231/255, blue: 226/255, alpha: 1)
    static var brown = UIColor(red: 189/255, green: 150/255, blue: 104/255, alpha: 1)
    static var darkGreen = UIColor(red: 23/255, green: 26/255, blue: 22/255, alpha: 1)
    static var red = UIColor(red: 200/255, green: 0/255, blue: 21/255, alpha: 1)
    
    static func generalAppearance() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
}
