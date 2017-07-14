//
//  ViewController.swift
//  SampleTableBinding
//
//  Created by avnish kumar on 15/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var arrayController: NSArrayController!
    private dynamic var arrayOfEmployee = [Employee]()
    override func viewDidLoad() {
        super.viewDidLoad()

        arrayOfEmployee = [Employee(id: "121", name: "avnish"), Employee(id: "123", name: "manish"), Employee(id: "126", name: "nishant")]
       // arrayController.add(contentsOf: arrayOfEmployee)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func rowSelected(sender:AnyObject) {
        
        let selectedObject = arrayController.selectedObjects
        for selec in selectedObject! {
            if let sele = selec as? Employee{
                print(sele.id)
            }
        }
        
    }


}

