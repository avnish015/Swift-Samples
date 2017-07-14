//
//  ViewController.swift
//  BindingLabelTextfield
//
//  Created by avnish kumar on 20/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var tetxtField: NSTextField!
    @IBOutlet weak var slider: NSSlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
        self.imageView.image = NSImage(byReferencing: URL(fileURLWithPath: "https://ibb.co/cA0xTQ"))
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

