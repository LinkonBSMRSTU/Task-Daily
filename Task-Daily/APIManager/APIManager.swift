//
//  APIManager.swift
//  Task-Daily
//
//  Created by Fazle Rabbi Linkon on 9/2/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import Foundation
import Alamofire


class APIManager {

    static let sharedInstance = APIManager()

    let successMessage = "Account was created successfully!"


    // User Registration API
    func registerAPI(register: RegisterModel, completionHandler: @escaping (Bool, String) -> ()) {

        let headers: HTTPHeaders = [
                .contentType("application/json"),
                .accept("application/json")
        ]

        AF.request(register_url, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])

                    if response.response?.statusCode == 200 {
                        completionHandler(true, self.successMessage)

                    } else if response.response?.statusCode == 201 {
                        completionHandler(true, self.successMessage)
                    } else if response.response?.statusCode == 500 {
                        completionHandler(false, "Internal server error. Please try again.")
                    }
                    else {
                        completionHandler(false, (json as AnyObject).value(forKey: "message") as! String)
                    }
                } catch {
                    print(error.localizedDescription)
//                    completionHandler(false, (json as? AnyObject)?.value(forKey: "message") as! String)
                }

            case .failure(let err):
                print(err.localizedDescription)
//                completionHandler(false, (json as? AnyObject)?.value(forKey: "message") as! String)
            }
        }
    }

    // User Login API
    func loginAPI(login: LoginModel, completionHandler: @escaping (Bool, String) -> ()) {

        let headers: HTTPHeaders = [
                .contentType("application/json"),
                .accept("application/json")
        ]

        AF.request(login_url, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers).response { response in

            debugPrint(response)

            switch response.result {

            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])

                    if response.response?.statusCode == 200 {
                        completionHandler(true, (json as AnyObject).value(forKey: "access_token") as! String)
                    } else if response.response?.statusCode == 201 {
                        completionHandler(true, self.successMessage)
                    } else if response.response?.statusCode == 500 {
                        completionHandler(false, "Internal server error. Please try again.")
                    }
                    else {
                        completionHandler(false, (json as AnyObject).value(forKey: "error") as! String)
                    }
                } catch {
                    print(error.localizedDescription)
                    //                    completionHandler(false, (json as? AnyObject)?.value(forKey: "message") as! String)
                }

            case .failure(let err):
                print(err.localizedDescription)
                //                completionHandler(false, (json as? AnyObject)?.value(forKey: "message") as! String)
            }
        }
    }


    func addTaskAPI(addTask: AddTaskModel, completionHandler: @escaping (Bool, String) -> ()) {

        let token = UserDefaults.standard.object(forKey: "accessToken") as? String

        let headers: HTTPHeaders = [
                .contentType("application/json"),
                .accept("application/json"),
                .authorization("Bearer \(String(token!))")
        ]

        AF.request(addTask_url, method: .post, parameters: addTask, encoder: JSONParameterEncoder.default, headers: headers).response { response in

            debugPrint(response)

            switch response.result {

            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])

                    if response.response?.statusCode == 200 {
                        completionHandler(true, "Task Added Successfully!")
                    } else if response.response?.statusCode == 500 {
                        completionHandler(false, "Internal server error. Please try again.")
                    }
                    else {
                        completionHandler(false, (json as AnyObject).value(forKey: "error") as! String)
                    }
                } catch {
                    print(error.localizedDescription)
                    //                    completionHandler(false, (json as? AnyObject)?.value(forKey: "message") as! String)
                }

            case .failure(let err):
                print(err.localizedDescription)
                //                completionHandler(false, (json as? AnyObject)?.value(forKey: "message") as! String)
            }
        }
    }



    func logOutAPI(completionHandler: @escaping (Bool, String) -> ()) {

        let token = UserDefaults.standard.object(forKey: "accessToken") as? String

        let headers: HTTPHeaders = [
                .contentType("application/json"),
                .accept("application/json"),
                .authorization("Bearer \(String(token!))")
        ]

        print(headers)
        AF.request(logOut_url, method: .post, headers: headers).response { response in

            debugPrint(response)

            switch response.result {

            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])

                    if response.response?.statusCode == 200 {
                        completionHandler(true, "Logged Out Successfully!")
                    } else if response.response?.statusCode == 500 {
                        completionHandler(false, "Internal server error. Please try again.")
                    }
                    else {
                        completionHandler(false, (json as AnyObject).value(forKey: "message") as! String)
                    }
                } catch {
                    print(error.localizedDescription)
                    //                    completionHandler(false, (json as? AnyObject)?.value(forKey: "message") as! String)
                }

            case .failure(let err):
                print(err.localizedDescription)
                //                completionHandler(false, (json as? AnyObject)?.value(forKey: "message") as! String)
            }
        }
    }

    func taskDataAPI(completionHandler: @escaping (Bool, [Datum]?, String) -> ()) {

        let token = UserDefaults.standard.object(forKey: "accessToken") as? String

        let headers: HTTPHeaders = [
                .contentType("application/json"),
                .accept("application/json"),
                .authorization("Bearer \(String(token!))")
        ]

        debugPrint(headers)

        AF.request(taskData_url, method: .get, headers: headers).response { response in

            debugPrint(response)

            switch response.result {

            case .success(let data):

                do {

                    let users = try JSONDecoder().decode(TaskDataModel.self, from: data!)

                    if response.response?.statusCode == 200 {

                        debugPrint(users.data)
                        completionHandler(true, users.data, "Data Fetched Successfully.")

                    } else if response.response?.statusCode == 500 {

                        completionHandler(false, nil, "Internal server error. Please try again.")

                    }
                    else {
                        completionHandler(false, nil, (users as AnyObject).value(forKey: "message") as! String)
                    }

                } catch {
                    print(error.localizedDescription)
                    completionHandler(false, nil, "Could not load data.")
                }

            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(false, nil, "Connection to server failed.")
            }
        }
    }



    func taskDeleteAPI(taskID: Int, completionHandler: @escaping (Bool, String) -> ()) {

        let headers: HTTPHeaders = [
                .contentType("application/json"),
                .accept("application/json"),
        ]

        debugPrint(headers)

        var deleteTask_url = "\(taskDelete_url)/\(taskID)"

        AF.request(deleteTask_url, method: .delete, headers: headers).response { response in

            debugPrint(response)

            switch response.result {

            case .success(let data):

                debugPrint(data as Any)
                if response.response?.statusCode == 200 {

                    completionHandler(true, "Data was deleted Successfully.")

                } else if response.response?.statusCode == 500 {

                    completionHandler(false, "Internal server error. Please try again.")

                }
                else {
                    completionHandler(false, "Couldn't delete the task.")
                }


            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(false, "Connection to server failed.")
            }
        }
    }
}
