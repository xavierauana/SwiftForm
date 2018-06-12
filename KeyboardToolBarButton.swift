//
//  KeyboardToolBarButton.swift
//  FormLib
//
//  Created by Xavier Au on 11/6/2018.
//  Copyright © 2018 anacreation.com. All rights reserved.
//

import Foundation
import UIKit

enum KeyboardToolbarButton: Int {
    
    case done = 0
    case cancel
    case back, backDisabled
    case forward, forwardDisabled
    
    func createButton(target: Any?, action: Selector?) -> UIBarButtonItem {
        var button: UIBarButtonItem!
        
        switch self {
        case .back:
            button = UIBarButtonItem(image: #imageLiteral(resourceName: "up-arrow"), style: .plain, target: target, action: action)
            
        case .backDisabled:
            button = UIBarButtonItem(image: #imageLiteral(resourceName: "up-arrow"), style: .plain, target: target, action: action)
            button.isEnabled = false
        case .forward:
            button = UIBarButtonItem(image: #imageLiteral(resourceName: "down-arrow"), style: .plain, target: target, action: action)
        case .forwardDisabled:
            button = UIBarButtonItem(image: #imageLiteral(resourceName: "down-arrow"), style: .plain, target: target, action: action)
            button.isEnabled = false
        case .done:
            button = UIBarButtonItem(title: "done", style: .plain, target: target, action: action)
        case .cancel:
            button = UIBarButtonItem(title: "cancel", style: .plain, target: target, action: action)
        }
        button.tag = rawValue
        return button
    }
    
    static func detectType(barButton: UIBarButtonItem) -> KeyboardToolbarButton? {
        return KeyboardToolbarButton(rawValue: barButton.tag)
    }
}
