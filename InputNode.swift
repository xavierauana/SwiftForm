//
//  InputNode.swift
//  FormLib
//
//  Created by Xavier Au on 11/6/2018.
//  Copyright © 2018 anacreation.com. All rights reserved.
//

import Foundation

class InputNode{
    
    var previous:InputNode?
    
    var next:InputNode?
    
    let input:Input
    
    init(input:Input) {
        self.input = input
    }
}
