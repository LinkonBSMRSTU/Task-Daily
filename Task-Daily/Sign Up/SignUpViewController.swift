//
//  SignUpViewController.swift
//  Task-Daily
//
//  Created by Fazle Rabbi Linkon on 8/2/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import UIKit

class SignUpViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @IBAction func signUpButtonPressed(_ sender: Any) {

        if self.ValidateSignUpCredential() {
            Indicator.sharedInstance.showIndicator()
            self.callSignUpApi()
        }
    }

    @IBAction func signInButtonPressed(_ sender: Any) {

        self.navigationController?.popViewController(animated: true)
    }

    func callSignUpApi() {

        guard let name = self.nameTextField.text else {
            return
        }
        guard let email = self.emailTextField.text else {
            return
        }
        guard let password = self.passwordTextField.text else {
            return
        }
        guard let password_confirmation = self.passwordTextField.text else {
            return
        }
        

        let registerData = RegisterModel(name: name, email: email, password: password, password_confirmation: password_confirmation)
        APIManager.sharedInstance.registerAPI(register: registerData) { (success, message) in

            if success {

                Indicator.sharedInstance.hideIndicator()
                self.openAlert(title: "Success", message: "Account Created Successfully! \n Login to continue.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    
                    if let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController {
                        self.navigationController?.pushViewController (loginVC, animated: true)
                    }
                    
                }])

            } else {
                Indicator.sharedInstance.hideIndicator()
                self.openAlert(title: "Error", message: message, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }
        }
    }

}




extension SignUpViewController {

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

extension SignUpViewController {

    fileprivate func ValidateSignUpCredential() -> Bool {

        if let fullName = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text {

            if fullName == "" {

                openAlert(title: "Error", message: "Please enter your full name.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])

            } else if email == "" {

                openAlert(title: "Error", message: "Please enter your email.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])

            } else if password == "" {

                openAlert(title: "Error", message: "Please set up a password.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])

            } else if confirmPassword == "" {

                openAlert(title: "Error", message: "Please re-enter your password to vonfirm.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])

            }
            else {

                if !email.validateEmailId() {

                    openAlert(title: "Error", message: "Email enter a valid email address", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                        print("Okay clicked!")
                    }])

                } else if !password.validatePassword() {

                    openAlert(title: "Error", message: "Please enter a valid password.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                        print("Okay clicked!")
                    }])

                    self.passwordTextField.text = ""
                    self.confirmPasswordTextField.text = ""

                } else if password != confirmPassword {

                    openAlert(title: "Error", message: "Password doesn't match.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                        self.passwordTextField.text = ""
                        self.confirmPasswordTextField.text = ""
                        print("Okay clicked!")
                    }])

                } else {
                    // Navigation - Home Screen
                    return true
                }

            }
        } else {
            openAlert(title: "Error", message: "Please enter your login credential first.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay clicked!")
            }])
        }
        return false
    }

}
