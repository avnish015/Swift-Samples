//
//  Model.swift
//  SampleTableBinding
//
//  Created by avnish kumar on 16/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//
import Cocoa

class Employee:NSObject {
    
    var id:String = ""
    var name:String = ""
    
    init(id:String, name:String) {
        self.id = id
        self.name = name
        super.init()
    }
}
