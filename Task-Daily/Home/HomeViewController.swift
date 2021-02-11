//
//  HomeViewController.swift
//  Task-Daily
//
//  Created by Fazle Rabbi Linkon on 10/2/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!

    var taskDataArray: [Datum] = []
    var workCount = 0
    var personalCount = 0
    var shoppingCount = 0
    var healthCount = 0
    
    var typeArray = ["Work", "Personal", "Shopping", "Health"]
    var countArray = ["7", "5", "6", "4"]
    var timeArray = ["8:00 am", "8:30 am", "9:00 am", "9:30 am", "10:00 am", "10:30 am", "11:00 am", "11:30 am", "12:00 pm", "12:30 pm", "1:00 pm", "1:30 pm", "2:00 pm", "2:30 pm", "3:00 pm", "3:30 pm", "4:00 pm", "4:30 pm", "5:00 pm", "5:30 pm", "6:00 pm", "6:30 pm", "7:00 pm", "7:30 pm", "8:00 pm", "8:30 pm", "9:00 pm", "9:30 pm", "10:00 pm", "10:30 pm", "11:00 pm", "11:30 pm", "12:00 am", "12:30 am", "1:00 am", "1:30 am", "2:00 am", "2:30 am", "3:00 am", "3:30 am", "4:00 am", "4:30 am", "5:00 am", "5:30 am", "6:00 am", "6:30 am", "7:00 am", "7:30 am"]


    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.initTableandCollectionView()
        self.callTaskDataAPI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func initTableandCollectionView() {

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(UINib(nibName: TaskTableViewCell.className, bundle: nil), forCellReuseIdentifier: TaskTableViewCell.className)
        self.collectionView.register(UINib(nibName: TypeCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: TypeCollectionViewCell.className)
    }

    @IBAction func addTaskButtonPressed(_ sender: Any) {
        if let addTaskVC = self.storyboard?.instantiateViewController(identifier: "AddTaskViewController") as? AddTaskViewController {
            self.navigationController?.pushViewController (addTaskVC, animated: true)
        }
    }

    @IBAction func logOutButtonPressed(_ sender: Any) {
        if isUserLoggedIN(key: "accessToken") {
            Indicator.sharedInstance.showIndicator()
            self.callLogOutAPI()
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.timeArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell

        if self.taskDataArray.count > 0 {
            
            let data = self.taskDataArray[indexPath.row]
            cell.timeLabel.text = self.timeArray[indexPath.row]
            cell.taskTitle.text = String(data.title)
            cell.taskDetails.text = "\(data.datumDescription)\n\(data.startTime) - \(data.endTime)"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let loginVC = self.storyboard?.instantiateViewController(identifier: "DeleteViewController") as? DeleteViewController {
            self.navigationController?.pushViewController (loginVC, animated: true)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }



    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeCollectionViewCell", for: indexPath) as! TypeCollectionViewCell
  
        if self.typeArray.count > 0 && self.countArray.count > 0 {
            cell.taskType.text = self.typeArray[indexPath.row]
            cell.taskCount.text = self.countArray[indexPath.row]
        }
        
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: self.collectionView.frame.size.width/4, height: (self.collectionView.frame.size.height / 2))
    }

}

extension HomeViewController {
    private func callLogOutAPI () {

        APIManager.sharedInstance.logOutAPI { (success, message) in

            if success {

                Indicator.sharedInstance.hideIndicator()
                self.openAlert(title: "Success", message: "Logged Out Successfully!", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in

                    UserDefaults.standard.set("", forKey: "accessToken")
                    
                    if let initVC = self.storyboard?.instantiateViewController(identifier: "InitialViewController") as? InitialViewController {
                        self.navigationController?.pushViewController (initVC, animated: true)
                    }

                }])


            } else {
                Indicator.sharedInstance.hideIndicator()
                self.openAlert(title: "Error", message: message, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                }])
            }
        }
    }
}


extension HomeViewController {

    func callTaskDataAPI() {

        APIManager.sharedInstance.taskDataAPI { (success, dataArray, message) in
            

            if success {

                if let taskDataArray = dataArray {
                    self.taskDataArray = taskDataArray
                    
                    
                    self.workCount = self.taskDataArray.filter { $0.datumDescription.contains("Work") }.count
                    self.healthCount = self.taskDataArray.filter { $0.datumDescription.contains("Personal") }.count
                    self.shoppingCount = self.taskDataArray.filter { $0.datumDescription.contains("Shopping") }.count
                    self.personalCount = self.taskDataArray.filter { $0.datumDescription.contains("Health") }.count
//                    self.countArray = [self.workCount, self.healthCount, self.shoppingCount, self.personalCount]
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.collectionView.reloadData()
                    }
                }

            } else {
                self.openAlert(title: "Error", message: message, alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in

                }])
            }
        }
    }
}
