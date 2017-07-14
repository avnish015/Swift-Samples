//
//  AppDelegate.swift
//  DontSleep
//
//  Created by avnish kumar on 01/02/16.
//  Copyright © 2016 avnish kumar. All rights reserved.
//

import Cocoa


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate
{
    //Preference Window
    var preferencesWindowController:NSWindowController?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
       preferencesWindowController = NSStoryboard(name: StoryBoardName.preferences, bundle: nil).instantiateInitialController() as? NSWindowController
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
    @IBAction func showPreferencesWindow(_ sender:AnyObject) {
       NSApplication.shared().activate(ignoringOtherApps: true)
        preferencesWindowController!.showWindow(sender)
        self.preferencesWindowController!.window?.delegate = self
    }
    
    func windowWillClose(_ notification: Notification) {
        
        
    }
 
}

