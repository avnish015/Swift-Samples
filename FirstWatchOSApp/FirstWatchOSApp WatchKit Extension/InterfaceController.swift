//
//  InterfaceController.swift
//  FirstWatchOSApp WatchKit Extension
//
//  Created by avnish kumar on 08/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    var employeeArray = [Employee]()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        let session = WCSession.default()
        session.delegate = self
        session.activate()
        super.willActivate()
    }
    
    
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func updateTable() {
        
        table.setNumberOfRows(employeeArray.count, withRowType: Constant.employeeCustomCell)
        for i in 0..<table.numberOfRows {
            
            let controller = table.rowController(at: i) as? MainTableType
            controller?.textLabel.setText(employeeArray[i].id)
            controller?.nameLabel.setText(employeeArray[i].name)
        }
    }
}

extension InterfaceController:WCSessionDelegate {
    
    @available(watchOS 2.2, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        if let employeeJSONArray = message[Constant.employeeList] as? Data {
            
            let jsonDecoder = JSONDecoder()
            do {
                let decodedArrayOfEmployee = try jsonDecoder.decode([Employee].self, from: employeeJSONArray)
                employeeArray = decodedArrayOfEmployee
            }catch {
                print(error)
            }
            
        }
        updateTable()
    }

}

