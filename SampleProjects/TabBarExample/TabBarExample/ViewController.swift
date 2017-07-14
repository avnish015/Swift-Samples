//
//  ViewController.swift
//  TabBarExample
//
//  Created by avnish kumar on 28/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        self.imageView.addGestureRecognizer(tapGestureRecognizer)
        getAllPosts()
        print(NSLocalizedString("NAME_H", comment: "Hehehehe"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getAllPosts() {
        
        let session = URLSession.shared
        var urlRequest = URLRequest(url: URL(string: "http://10.2.2.51:8082/SpotFood/GetAllPost")!)
        urlRequest.httpMethod = "Get"
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let response = data else{
                print(error!)
                return
            }
            print(response)
        }.resume()
    }
}

