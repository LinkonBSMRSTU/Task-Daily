//
//  DeleteViewController.swift
//  Task-Daily
//
//  Created by Fazle Rabbi Linkon on 11/2/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import UIKit

class DeleteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var taskDataArray: [Datum] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.callTaskDataAPI()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func registerCell() {

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(UINib(nibName: EditTableViewCell.className, bundle: nil), forCellReuseIdentifier: EditTableViewCell.className)

    }


}

extension DeleteViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "EditTableViewCell", for: indexPath) as! EditTableViewCell


        if self.taskDataArray.count > 0 {

            let data = self.taskDataArray[indexPath.row]
            print(data.id)
            cell.titleLabel.text = String(data.title)
            cell.descriptionLabel.text = "\(data.datumDescription)\n\(data.startTime) - \(data.endTime)"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            print("index path of delete: \(indexPath)")

            if self.taskDataArray.count > 0 {
                let data = self.taskDataArray[indexPath.row]
                self.callTaskDeleteAPI(taskId: data.id)
            }
            Indicator.sharedInstance.showIndicator()
            self.tableView.reloadData()
            self.callTaskDataAPI()
            completionHandler(true)
        }


        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }

}

extension DeleteViewController {

    func callTaskDataAPI() {

        APIManager.sharedInstance.taskDataAPI { (success, dataArray, message) in

            if success {

                Indicator.sharedInstance.hideIndicator()
                if let taskDataArray = dataArray {
                    self.taskDataArray = taskDataArray

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }

            } else {
                Indicator.sharedInstance.hideIndicator()
                self.openAlert(title: "Error", message: message, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in

                }])
            }
        }
    }

    func callTaskDeleteAPI(taskId: Int) {

        APIManager.sharedInstance.taskDeleteAPI(taskID: taskId) { (success, message) in
            if success {

                self.openAlert(title: "Success", message: "Task was deleted", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

                }])


            } else {
                self.openAlert(title: "Error", message: message, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in

                }])
            }
        }

    }

}
