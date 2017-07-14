//
//  ViewController.swift
//  CoreDataExample
//
//  Created by avnish kumar on 16/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import Cocoa
import CoreData



class ViewController: NSViewController {
    
    
    @IBOutlet var arrayController: NSArrayController!
    let context = (NSApplication.shared().delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
//       
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
//        let result = try! context.fetch(request)
//        //let objebcts = context.insertedObjects
//        for object in result {
//            
//            if let ob = object as? Employee {
//                
//                print(ob.contactNumber!,ob.name!,ob.id!)
//            }
//        }
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func addButtonClicked(_ sender: NSToolbarItem) {
        
        self.performSegue(withIdentifier: "AddEmployee", sender: self)
    }
    
    @IBAction func deleteButtonClicked(_ sender: NSToolbarItem) {
        
        for index in arrayController.selectionIndexes {
            
            arrayController.remove(atArrangedObjectIndex: index)
            do{
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    override func rightMouseDown(with event: NSEvent) {
        
        
    }
}

