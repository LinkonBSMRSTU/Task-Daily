//
//  ViewController.swift
//  Task-Daily
//
//  Created by Fazle Rabbi Linkon on 8/2/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginClicked(_ sender: Any) {
        
        if let signUpVC = self.storyboard?.instantiateViewController(identifier: "SignUpTableViewController") as? SignUpViewController {
            self.navigationController?.pushViewController (signUpVC, animated: true)
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginTableViewController") as? LoginViewController {
            self.navigationController?.pushViewController (loginVC, animated: true)
        }
    }
}

