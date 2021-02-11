//
//  NSUserDefaults + Extension.swift
//  Task-Daily
//
//  Created by Fazle Rabbi Linkon on 10/2/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func saveObject(key:String, value:String) {
        let userefaults = UserDefaults.standard
        userefaults.set(value, forKey: key)
        userefaults.synchronize()
    }
    
    public func removeObject(key:String) {
        let userefaults = UserDefaults.standard
        userefaults.removeObject(forKey: key)
        userefaults.synchronize()
    }
    
    public func isUserLoggedIN(key: String) -> Bool {
        let str = UserDefaults.standard.object(forKey: key) as! String
        return str.count > 0 ? true : false
    }
    
    public func loggedUserName(key: String) -> String {
        let str = UserDefaults.standard.object(forKey: key) as? String
        return str == nil ? "" : str!
    }
    
    public func logout() {
        UserDefaults.standard.set("", forKey: "accessToken")
    }
}
