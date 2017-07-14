//
//  ViewController.swift
//  AdaptiveUIdesign
//
//  Created by avnish kumar on 29/05/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let linkedList = Linkedlist()
        linkedList.insert(data: 10)
        linkedList.insert(data: 40)
        linkedList.insert(data: 20)
        linkedList.insert(data: 30)
        linkedList.insert(data: 50)
        linkedList.display()
        linkedList.reverseList()
        linkedList.findMiddle()
        print("-------------REVERSE LIST---------------")
        linkedList.display()
        print("-------------SHORT LIST---------------")
        linkedList.sortList()
        linkedList.display()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class Linkedlist {
    
    private var head:Node?
    class Node {
        
        var value = 0
        var next:Node?
        init(value:Int) {
            
            self.value = value
        }
    }
    func insert(data:Int) {
        
        if head == nil {
            
            head =  Node(value: data)
        }else {
            var cur = head
            while cur?.next != nil {
                cur = cur?.next
            }
            let node = Node(value: data)
            cur?.next = node
        }
    }
    
    
    func display() {
        
        var cur = head
            while cur != nil {
                print(cur!.value)
                cur = cur!.next
            }
        
    }
    
    func reverseList() {
        
        var prev:Node? = nil
        var cur = head
        var nt = head?.next
        
        while cur != nil {
            
            cur?.next = prev
            prev = cur
            cur = nt
            nt = nt?.next
        }
        head = prev
    }
    
    func findMiddle() {
        
        var cur = head
        var nt = head?.next
        
        while nt != nil {
            
            cur = cur?.next
            nt = nt?.next?.next
        }
        print(cur!.value)
    }
    
    func sortList() {
        
        var cur = head
        
        while cur != nil {
           
            var temp = cur
            while temp != nil {
                
                if (cur?.value)! > (temp?.value)! {
                    
                    let t = temp?.value
                    temp?.value = (cur?.value)!
                    cur?.value = t!
                }
                temp = temp?.next
            }
            cur = cur?.next
        }

    }
}



