//
//  AddTaskModel.swift
//  Task-Daily
//
//  Created by Fazle Rabbi Linkon on 11/2/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import Foundation

struct AddTaskModel: Encodable {
    let title: String
    let description: String
    let category: String
    let start_time: String
    let end_time: String
}
