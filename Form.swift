//
//  Form.swift
//  FormLib
//
//  Created by Xavier Au on 11/6/2018.
//  Copyright © 2018 anacreation.com. All rights reserved.
//

import Foundation
import UIKit

enum ListError: Error {
    case NoHead
}
enum Method {
    case post
    case get
    case put
    case delete
}


class Form:KeyboardToolbarDelegate {
    
    var head:InputNode?
    
    var method:Method?
    
    var action:String?
    
    func createInput(type:InputType, name:String)->Input{
        
        let input = Input(type: type, name:name)
        
        let node = InputNode(input: input)
        
        addToList(node)
        
        return input
        
    }
    
    func addInput(input:Input){
        
        let node = InputNode(input: input)
        
        addToList(node)
    }
    
    func getInputByName(_ name:String)->Input?{
        
        return findByName(name, nil)
        
    }
    
    private func findByName(_ name:String, _ node:InputNode?)->Input?{
        
        let _node = node ?? head
        
        guard let checkNode = _node else {return nil}
        
        if checkNode.input.name == name {
            
            return checkNode.input
            
        }else if checkNode.next != nil {
            
            return findByName(name, checkNode.next!)
            
        }else{
            return nil
        }
        
    }
    
    private func getLastInputNode(_ node:InputNode?)->InputNode?{
        
        let _node = node ?? head
        
        guard let checkNode = _node else {return nil}
        
        if let nextNode = checkNode.next {
            
            return getLastInputNode(nextNode)
            
        }else {
            
            return checkNode
        }
    }
    
    private func addToList(_ node:InputNode){
        
        if head == nil {
            
            head = node
            
        }else{
            
            if let lastNode = getLastInputNode(nil) {
                
                lastNode.next = node
                
                node.previous = lastNode
            }
        }
        
        var leftButtons = [KeyboardToolbarButton]()
        
        if node.previous != nil {
            leftButtons.append(KeyboardToolbarButton.back)
        }else{
            leftButtons.append(KeyboardToolbarButton.backDisabled)
        }
        
        
        if node.next != nil {
            leftButtons.append(KeyboardToolbarButton.forward)
        }else{
            leftButtons.append(KeyboardToolbarButton.forwardDisabled)
        }
        
        setInputFieldKeyboardAcessoryView(node: node, leftButtons: leftButtons)
        
        if let previousNode = node.previous {
            
            var newLeftButtons = [KeyboardToolbarButton]()
            
            if previousNode.previous != nil {
                newLeftButtons.append(KeyboardToolbarButton.back)
            }else{
                newLeftButtons.append(KeyboardToolbarButton.backDisabled)
            }
            
            
            if previousNode.next != nil {
                newLeftButtons.append(KeyboardToolbarButton.forward)
            }else{
                newLeftButtons.append(KeyboardToolbarButton.forwardDisabled)
            }
            
            setInputFieldKeyboardAcessoryView(node: previousNode, leftButtons: newLeftButtons)
            
            
        }
    }
    
    private func setInputFieldKeyboardAcessoryView(node:InputNode, leftButtons: [KeyboardToolbarButton] = [], rightButtons: [KeyboardToolbarButton] = []) {
        
        let toolbar = KeyboardToolbar()
        
        toolbar.toolBarDelegate = self
        
        toolbar.node = node
        
        toolbar.setup(leftButtons: leftButtons, rightButtons: rightButtons)
        
        node.input.container.inputAccessoryView = toolbar
    }
    
    func keyboardToolbar(button: UIBarButtonItem, type: KeyboardToolbarButton, tappedIn toolbar: KeyboardToolbar) {
        
        if type == .back {
            
            if let node = toolbar.node?.previous {
                
                node.input.container.becomeFirstResponder()
            }
        }else if type == .forward {
            
            if let node = toolbar.node?.next {
                
                node.input.container.becomeFirstResponder()
            }
        }
        
            print("Tapped button type: \(type)")
        
        print("node is: \(toolbar.node!)")
    }
    
    func getValues(node:InputNode? = nil, values:[String:String]=[String:String]())->[String:String]?{
        
        var _node:InputNode
        
        if node != nil {
            _node = node!
        }else if head != nil {
            _node = head!
        }else{
            return nil
        }
        
        let key = _node.input.name
        let value = _node.input.value
        
        var _values = values
        _values[key] = value
        
        if _node.next != nil {
            return getValues(node: _node.next, values: _values)
        }
        
        
        return _values
    }
    
    func setValueForName(name:String, value:String){
        
        var node:InputNode? = nil
        var done = false
        var check = head
        
        repeat{
            guard let inputNode = check else {break}
            
            if inputNode.input.name == name {
                node = inputNode
                break
            }
            
            if check?.next != nil {
                check = check?.next
            }else{
                done = true
            }
        }while(node == nil || done != true)
        
        guard let _node = node else {return}
        
        _node.input.value = value
        
    }
    
    func submit(){
        
        if let url = URL(string: action!) {
            
            print("url absolute string is \(url.absoluteURL)")
            
            let values = getValues()
            
            print("values are \(values)")
            print("method are \(method)")
            
        }else{
            
            print("Cannot parse action to url")
        }
        
        
        
    }
}
