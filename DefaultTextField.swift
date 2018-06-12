//
//  DefaultTextField.swift
//  FormLib
//
//  Created by Xavier Au on 11/6/2018.
//  Copyright © 2018 anacreation.com. All rights reserved.
//

import Foundation
import UIKit

class DefaultTextField:UITextField {
    
    private var padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,padding)
    }
}
