//
//  RegisterModel.swift
//  Task-Daily
//
//  Created by Fazle Rabbi Linkon on 9/2/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import Foundation

struct RegisterModel: Encodable {
    let name: String
    let email: String
    let password: String
    let password_confirmation: String
}
