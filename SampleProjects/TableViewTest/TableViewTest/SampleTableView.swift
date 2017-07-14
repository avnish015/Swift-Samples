//
//  SampleTableView.swift
//  TableViewTest
//
//  Created by avnish kumar on 06/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import Cocoa

class SampleTableView: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

extension SampleTableView:NSTableViewDataSource, NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        return tableView.make(withIdentifier: "Hello", owner: self)
    }
    func numberOfRows(in tableView: NSTableView) -> Int {
        
        return 6
    }
}
