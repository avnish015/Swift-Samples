//
//  ViewController.swift
//  FirstWatchOSApp
//
//  Created by avnish kumar on 08/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import UIKit
import WatchKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
    let session = WCSession.default()
    @available(iOS 9.3, *)
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    @available(iOS 9.3, *)
    func sessionDidDeactivate(_ session: WCSession) {
        
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
        sendMessage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = WCSession.default()
        session.delegate = self
        session.activate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendMessage() {
        
        if session.isReachable && session.isPaired {
            
            session.sendMessage(["message":"Hello Avnish"], replyHandler: { (replay) in
                
                print(replay)
            }, errorHandler: { (error) in
                print(error)
            })
            
        }
    }
    

}
