//
//  ViewController.swift
//  HandsOnUI
//
//  Created by avnish kumar on 13/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var button: NSButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        button.translatesAutoresizingMaskIntoConstraints = false

        // Do any additional setup after loading the view.
        addConstraint()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func addConstraint() {
        NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
    }

}

