//
//  ViewController.swift
//  LoginWithFacebook
//
//  Created by avnish kumar on 30/05/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin


class ViewController: UIViewController, LoginButtonDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = LoginButton(publishPermissions: [.publishActions])
        button.delegate = self
        button.center = view.center
        view.addSubview(button)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print("Did complete login via LoginButton with result \(result)")
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("Did logout via LoginButton")
    }

}

