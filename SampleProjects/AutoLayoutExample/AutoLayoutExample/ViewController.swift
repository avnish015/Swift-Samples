//
//  ViewController.swift
//  AutoLayoutExample
//
//  Created by avnish kumar on 06/07/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottmConstraint: NSLayoutConstraint!
    @IBOutlet weak var customView: ALECustomView!
    var zeroHeightConstraint:NSLayoutConstraint?
    var isViewActive:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zeroHeightConstraint = customView.heightAnchor.constraint(equalToConstant: 0)
//        let upGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.imageViewSwiped(_:)))
//        upGestureRecognizer.direction = .up
//        imageView.addGestureRecognizer(upGestureRecognizer)
//        
//        let downGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.imageViewSwiped(_:)))
//        downGestureRecognizer.direction = .down
//        imageView.addGestureRecognizer(downGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func changeConstarint() {
        if isViewActive {
            zeroHeightConstraint?.isActive = false
            bottmConstraint.isActive = true
        }else {
            bottmConstraint.isActive = false
            zeroHeightConstraint?.isActive = true
        }
        UIView.animate(withDuration: 0.25) { 
            self.view.layoutIfNeeded()
        }
    }
    
    func imageViewSwiped(_ recognizer:UISwipeGestureRecognizer) {
        
        if recognizer.direction == UISwipeGestureRecognizerDirection.up {
            self.isViewActive = false
            self.changeConstarint()
        }else if recognizer.direction == UISwipeGestureRecognizerDirection.down {
            self.isViewActive = true
            self.changeConstarint()
        }
    }
    
    func transform(_ translation:CGPoint) -> CGAffineTransform{
        
        let moveBy = CGAffineTransform(translationX: translation.x, y: translation.y)
        //moveBy.scaledBy(x: 0.0 , y: 0.0)
        let rotation = -sin(translation.x/(imageView.frame.width * 4.0))
        return moveBy.rotated(by: rotation)
    }

    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            let transformat = sender.translation(in: view)
            imageView.transform = transform(transformat)
        case .ended:

//            UIView.animate(withDuration: 0.25, animations: {
//                self.imageView.transform = .identity
//            })
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: [], animations: {
                self.imageView.transform = .identity
            }, completion: nil)
        default: break
        }
        
    }
}

