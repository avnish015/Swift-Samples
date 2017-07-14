//
//  ViewController.swift
//  AnimationIOS
//
//  Created by avnish kumar on 14/07/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var secCustomView: UIView!
    @IBOutlet weak var customView: UIView!
    var oldFrame = CGRect()
    var secOldFrame = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.layer.cornerRadius = customView.frame.width / 2
        customView.layer.masksToBounds = true
        oldFrame = self.customView.frame
        
        
        secCustomView.layer.cornerRadius = secCustomView.frame.width / 2
        secCustomView.layer.masksToBounds = true
        secOldFrame = secCustomView.frame
        moveLeftToRight()
    }
    
    func moveLeftToRight() {
        UIView.animate(withDuration: 5, animations: {
            
            let newFrame = self.customView.frame.offsetBy(dx: 345, dy: 0)
            self.customView.frame = newFrame
            
            let secNewFrame = self.secCustomView.frame.offsetBy(dx: 0, dy: 345)
            self.secCustomView.frame = secNewFrame
        }) { (flag) in
            
            self.moveRightToLeft()
        }
 
    }
    
    func moveRightToLeft() {
        UIView.animate(withDuration: 5, animations: {
            
            self.customView.frame = self.oldFrame
            self.secCustomView.frame = self.secOldFrame
        }) { (flag) in
            
            if flag {
                self.moveLeftToRight()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

