//
//  Input.swift
//  FormLib
//
//  Created by Xavier Au on 11/6/2018.
//  Copyright © 2018 anacreation.com. All rights reserved.
//

import Foundation
import UIKit

class Input{
    
    let type:InputType
    
    var value:String{
        get{
            return self.container.text ?? ""
        }
        set{
            self.container.text = newValue
        }
    }
    
    let name:String
    
    var container:UITextField
    
    init(type:InputType, name:String) {
        
        self.type = type
        
        self.name = name
        
        self.container = DefaultTextField()
        
        self.container.translatesAutoresizingMaskIntoConstraints = false
        
        self.createInputField()
        
        self.createInputFieldDefaultLayout()
        
    }
    
    private func createInputField(){
        
        switch type {
            
        case .email:
            
            container.keyboardType = .emailAddress
            
            break
            
        case .password:
            
            container.isSecureTextEntry = true
            
            break
            
        case .number:
            
            container.keyboardType = .decimalPad
            
            break
            
        default:
            
            container = UITextField()
        }
        
    }
    
    func setPlaceholder(_ string:String) {
        
        container.placeholder = string
    }
    
    private func createInputFieldDefaultLayout(){
        
        container.borderStyle = .roundedRect
    }
    
}
