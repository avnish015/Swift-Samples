//
//  ViewController.swift
//  SampleOutlineView
//
//  Created by avnish kumar on 23/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var outlineView: NSOutlineView!
    
    var arrayOfObj = [Person]()
    override func viewDidLoad() {
        super.viewDidLoad()

        let person1 = Person(name: "Santosh", children: [Person(name: "Mahesh", children:[Person]())])
        let person2 = Person(name: "rajesh", children: [Person(name: "Chintu", children:[Person]()), Person(name: "Pintu", children:[Person]())])
        let person3 = Person(name: "Manish", children: [Person(name: "Pinku", children:[Person(name:"sonu", children:[Person]())]), Person(name: "Tinku", children:[Person]())])

        arrayOfObj.append(person1)
        arrayOfObj.append(person2)
        arrayOfObj.append(person3)
  
        outlineView.reloadData()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

extension ViewController:NSOutlineViewDataSource, NSOutlineViewDelegate {
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        
        if let object = item as? Person {
            return object.children.count
        }
        return arrayOfObj.count
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        
        if let object = item as? Person {
            return object.children[index]
        }
        return arrayOfObj[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        
        if let obj = item as? Person {
            if obj.children.count > 0 {
                return true
            }
        }
        return false
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        
        let tableCellView = outlineView.make(withIdentifier: "NameCell", owner: self) as! NSTableCellView
        if let object = item as? Person {
            
            tableCellView.textField?.stringValue = object.name
        }
        return tableCellView
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        
        let object = outlineView.item(atRow: outlineView.selectedRow)
        if let object = object as? Person {
            
            print(object)
        }
    }
}

