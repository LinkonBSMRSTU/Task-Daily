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

    func callRegisterAPI(register: RegisterModel, completionHandler: @escaping (Bool, String) -> ()) {
        
        let headers: HTTPHeaders = [
                .contentType("application/json")
        ]

        AF.request(register_url, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    
                    if response.response?.statusCode == 200 {
                        completionHandler(true, self.successMessage)
                    } else {
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
}
