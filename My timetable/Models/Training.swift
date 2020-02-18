//
//  Training.swift
//  My timetable
//
//  Created by Васлий Николаев on 17.02.2020.
//  Copyright © 2020 Васлий Николаев. All rights reserved.
//

import Foundation

struct Training: Decodable {
    var name: String
    var place: String
    var teacher: String
    var teacher_v2: Teacher
    var startTime: String
    var endTime: String
    var weekDay: Int
    var pay: Bool
    var color: String
}

struct Teacher: Decodable {
    var short_name: String
    var name: String
}
