//
//  AddEmployeeViewController.swift
//  CoreDataExample
//
//  Created by avnish kumar on 19/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import Cocoa

class AddEmployeeViewController: NSViewController {

    let context = (NSApplication.shared().delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var idTextView: NSTextField!
    @IBOutlet weak var nameTextView: NSTextField!
    @IBOutlet weak var contactNoTextFiled: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func addEmployee(_ sender: NSButton) {
        
        if contactNoTextFiled.stringValue != "" && nameTextView.stringValue != "" && idTextView.stringValue != "" {
            
            let employee = Employee(context: context)
            employee.contactNumber = contactNoTextFiled.stringValue
            employee.name = nameTextView.stringValue
            employee.id = idTextView.stringValue
            do {
                try context.save()
            }catch {
                print(error)
            }
        }
        self.dismissViewController(self)
    }
}
