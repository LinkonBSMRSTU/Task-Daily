//
//  AddTaskViewController.swift
//  Task-Daily
//
//  Created by Fazle Rabbi Linkon on 11/2/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDescription: UITextField!
    @IBOutlet weak var startPicker: UIDatePicker!
    @IBOutlet weak var endPicker: UIDatePicker!
    @IBOutlet weak var workButton: UIButton!
    @IBOutlet weak var PersonalButton: UIButton!
    @IBOutlet weak var HealthButton: UIButton!
    @IBOutlet weak var ShoppingButton: UIButton!
    @IBOutlet weak var GameButton: UIButton!
    @IBOutlet weak var OtherButton: UIButton!
    @IBOutlet weak var chosenTask: UILabel!
    
    var taskCategory: String? = ""
    var startTime: String? = ""
    var endTime: String? = ""


    override func viewDidLoad() {
        super.viewDidLoad()

        self.chosenTask.isHidden = true
        startPicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @objc func datePickerValueChanged(_ datePicker: UIDatePicker) {
        endPicker.minimumDate = Calendar.current.date(byAdding: .minute, value: 0, to: datePicker.date)
        // don't forget to add some checks (for example if your startPicker time is set to 23:59)
    }


    @IBAction func startTime(_ sender: Any) {
        let dateFormatter = DateFormatter()

        dateFormatter.timeStyle = DateFormatter.Style.short

        let startTime = dateFormatter.string(from: startPicker.date)
        self.startTime = startTime
    }



    @IBAction func endTime(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let endTime = dateFormatter.string(from: endPicker.date)
        self.endTime = endTime
    }
    
    @IBAction func workButtonClicked(_ sender: Any) {
        self.chosenTask.isHidden = false
        self.taskCategory = "Work"
        self.chosenTask.text = self.taskCategory
    }
    @IBAction func personalButtonClicked(_ sender: Any) {
        self.chosenTask.isHidden = false
        self.taskCategory = "Personal"
        self.chosenTask.text = self.taskCategory
    }
    @IBAction func healthButtonClicked(_ sender: Any) {
        self.chosenTask.isHidden = false
        self.taskCategory = "Health"
        self.chosenTask.text = self.taskCategory
    }
    @IBAction func shoppinButtonClicked(_ sender: Any) {
        self.chosenTask.isHidden = false
        self.taskCategory = "Shopping"
        self.chosenTask.text = self.taskCategory
    }
    @IBAction func gameButtonClicked(_ sender: Any) {
        self.chosenTask.isHidden = false
        self.taskCategory = "Game"
        self.chosenTask.text = self.taskCategory
    }
    @IBAction func otherButtonClicked(_ sender: Any) {
        self.chosenTask.isHidden = false
        self.taskCategory = "Other"
        self.chosenTask.text = self.taskCategory
    }

    func callAddTaskApi() {

        guard let title = self.taskTitle.text else {
            return
        }
        guard let description = self.taskDescription.text else {
            return
        }
        guard let category = self.taskCategory else {
            return
        }
        guard let startTime = self.startTime else {
            return
        }
        guard let endTime = self.endTime else {
            return
        }
        

        let taskData = AddTaskModel(title: title, description: description, category: category, start_time: startTime, end_time: endTime)

        APIManager.sharedInstance.addTaskAPI(addTask: taskData) { (success, message) in

            if success {

                Indicator.sharedInstance.hideIndicator()
                self.openAlert(title: "Success", message: message, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")

                    if let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController {
                        self.navigationController?.pushViewController (homeVC, animated: true)
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

    @IBAction func addTaskButtonPressed(_ sender: Any) {
        if self.validateTaskCredential() {
            Indicator.sharedInstance.showIndicator()
            self.callAddTaskApi()
        }
    }
    
}


extension AddTaskViewController {

    fileprivate func validateTaskCredential() -> Bool {

        if let title = self.taskTitle.text, let description = self.taskDescription.text, let startTime = self.startTime, let endTime = self.endTime {

            if title == "" {

                openAlert(title: "Error", message: "Please enter a task title.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])

            } else if description == "" {

                openAlert(title: "Error", message: "Please enter task details.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            } else if startTime == "" {

                openAlert(title: "Error", message: "Please select a task start time.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])

            } else if endTime == "" {

                openAlert(title: "Error", message: "Please select a task ending time.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])

            } else {
                return true
            }
        }
        else {
            openAlert(title: "Error", message: "Please enter task details first.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay clicked!")
            }])
        }
        return false
    }
}
