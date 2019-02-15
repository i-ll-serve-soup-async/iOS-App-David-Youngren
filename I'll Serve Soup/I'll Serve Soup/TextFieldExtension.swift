//
//  TextFieldExtension.swift
//  I'll Serve Soup
//
//  Created by Nathanael Youngren on 2/14/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setHeight() {
        let newHeight = self.frame.height * 1.5
        self.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
    }
}
