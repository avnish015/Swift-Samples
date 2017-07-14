//
//  AppDelegate.swift
//  DontSleepHelperApp
//
//  Created by avnish kumar on 25/02/16.
//  Copyright © 2016 avnish kumar. All rights reserved.
//

import Cocoa

//This is  Helper application. its sole job is to find out the path for the main application, launch it, and then terminate itself.
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let path = Bundle.main.bundlePath as NSString
        var components = path.pathComponents as NSArray
        components = components.subarray(with: NSRange(location: 0, length: components.count - 4)) as NSArray
        let newPath = NSString.path(withComponents: components as! [String])
        NSWorkspace.shared().launchApplication(newPath)
        NSApp.terminate(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

