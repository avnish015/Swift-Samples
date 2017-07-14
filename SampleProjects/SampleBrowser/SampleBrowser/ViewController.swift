//
//  ViewController.swift
//  SampleBrowser
//
//  Created by avnish kumar on 23/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSBrowserDelegate {

    @IBOutlet weak var browser: NSBrowser!
    let rootNode = BrowserFile(url: URL(fileURLWithPath: NSOpenStepRootDirectory()))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func rootItem(for browser: NSBrowser) -> Any? {
        
        return rootNode
    }
    func browser(_ browser: NSBrowser, numberOfChildrenOfItem item: Any?) -> Int {
        
        if let node = item as? BrowserFile, let children = node.children {
            return children.count
        }else {
            return 0
        }
    }
    
    func browser(_ browser: NSBrowser, objectValueForItem item: Any?) -> Any? {
        
        if let node = item as? BrowserFile {
            return node.displayName
        }
        return nil
    }
    
    func browser(_ browser: NSBrowser, child index: Int, ofItem item: Any?) -> Any {
        
        if let child = item as? BrowserFile {
        
            if  let children = child.children {
                if children.count > 0 {
                   return children[index]
                }
            }
        }
        return ""
    }
    
    func browser(_ browser: NSBrowser, isLeafItem item: Any?) -> Bool {
        
        if let child = item as? BrowserFile {
            return !child.isDirectory
        }
        return false
    }


}

