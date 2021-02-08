//
//  LoginTableViewController.swift
//  Task-Daily
//
//  Created by Fazle Rabbi Linkon on 8/2/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import UIKit

class LoginTableViewController: UITableViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 0.5
        loginButton.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tableViewHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height
        
        let centeringInset = (tableViewHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)
        
        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }

    // MARK: - Login Button Action
    
    @IBAction func loginButtonPressed(_ sender: Any) {
    }
    
    // MARK: - Forgot Password Button Action
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
    }
    
    // MARK: - SignUp Password Button Action
    @IBAction func signUpButtonPressed(_ sender: Any) {
        print("SignUp Clicked")
    }
}
