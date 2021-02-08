//
//  ForgotPasswordTableViewController.swift
//  Task-Daily
//
//  Created by Fazle Rabbi Linkon on 8/2/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import UIKit

class ForgotPasswordTableViewController: UITableViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func passwordResetPressed(_ sender: Any) {
        print("Send Request Pressed")
        if let resetPassVC = self.storyboard?.instantiateViewController(identifier: "ResetPasswordViewController") as? ResetPasswordViewController {
            self.navigationController?.pushViewController(resetPassVC, animated: true)
        }
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        print("Login Pressed")
        self.navigationController?.popViewController(animated: true)
    }
}

extension ForgotPasswordTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tableViewHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height
        
        let centeringInset = (tableViewHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)
        
        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }
}
