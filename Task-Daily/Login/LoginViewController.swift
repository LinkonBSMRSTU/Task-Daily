//
//  LoginViewController.swift
//  Task-Daily
//
//  Created by Fazle Rabbi Linkon on 8/2/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import UIKit

class LoginViewController: UITableViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Login Button Action

    @IBAction func loginButtonPressed(_ sender: Any) {
        if ValidateLoginCredential() {
            Indicator.sharedInstance.showIndicator()
            self.callLoginApi()
        }
    }

    // MARK: - Forgot Password Button Action

    @IBAction func forgotPasswordPressed(_ sender: Any) {
        if let forgotPassVC = self.storyboard?.instantiateViewController(identifier: "ForgotPasswordViewController") as? ForgotPasswordViewController {
            self.navigationController?.pushViewController (forgotPassVC, animated: true)
        }
    }

    // MARK: - SignUp Password Button Action
    @IBAction func signUpButtonPressed(_ sender: Any) {
        print("SignUp Clicked")
        if let signupVC = self.storyboard?.instantiateViewController(identifier: "SignUpViewController") as? SignUpViewController {
            self.navigationController?.pushViewController (signupVC, animated: true)
        }
    }

    private func callLoginApi() {

        guard let email = self.userNameTextField.text else {
            return
        }
        guard let password = self.passwordTextField.text else {
            return
        }

        let loginData = LoginModel(email: email, password: password)

        APIManager.sharedInstance.loginAPI(login: loginData) { (success, message) in

            if success {

                let accessToken = message
                self.saveObject(key: "accessToken", value: accessToken)
                Indicator.sharedInstance.hideIndicator()
                if let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController {
                    self.navigationController?.pushViewController (homeVC, animated: true)
                }

            } else {
                Indicator.sharedInstance.hideIndicator()
                self.openAlert(title: "Error", message: message, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    self.userNameTextField.text = ""
                    self.passwordTextField.text = ""
                }])
            }
        }
    }
}


extension LoginViewController {

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



extension LoginViewController {

    fileprivate func ValidateLoginCredential() -> Bool {

        if let userName = userNameTextField.text, let password = passwordTextField.text {

            if userName == "" {

                openAlert(title: "Error", message: "Please enter your email first.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])

            } else if password == "" {

                openAlert(title: "Error", message: "Please enter your password.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            } else if !userName.validateEmailId() {

                openAlert(title: "Error", message: "Email enter a valid email address", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                    self.userNameTextField.text = ""
                    self.passwordTextField.text = ""
                }])

            } else {
                return true
            }
        }
        else {
            openAlert(title: "Error", message: "Please enter your login credential first.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay clicked!")
            }])
        }
        return false
    }
}
