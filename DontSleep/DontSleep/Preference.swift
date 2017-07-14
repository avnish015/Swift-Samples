//
//  Preference.swift
//  DontSleep
//
//  Created by avnish kumar on 16/02/16.
//  Copyright © 2016 avnish kumar. All rights reserved.
//

import Cocoa

class Preference: NSObject {

    var title:String
    var defaultKey:String
    var value:Bool{
        set{
            self.willChangeValue(forKey: KeyName.value)
            if(newValue == true) {
                UserDefaults.standard.set(newValue, forKey: self.defaultKey)
            }else {
                UserDefaults.standard.removeObject(forKey: self.defaultKey)
            }
            self.didChangeValue(forKey: KeyName.value)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.bool(forKey: self.defaultKey)
        }
    }
    
     init(title:String, defaultKey:String) {
        self.title = title
        self.defaultKey = defaultKey
     }
}
