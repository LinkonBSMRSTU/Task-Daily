//
//  TaskDataModel.swift
//  Task-Daily
//
//  Created by Fazle Rabbi Linkon on 11/2/21.
//  Copyright © 2021 Fazle Rabbi Linkon. All rights reserved.
//

import Foundation

// MARK: - TaskDataModel
struct TaskDataModel: Codable {
    let code: Int
    let status, message: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let title, datumDescription, category, startTime: String
    let endTime: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case datumDescription = "description"
        case category
        case startTime = "start_time"
        case endTime = "end_time"
    }
}
