//
//  Weekdays.swift
//  My timetable
//
//  Created by Васлий Николаев on 18.02.2020.
//  Copyright © 2020 Васлий Николаев. All rights reserved.
//

import Foundation

enum Weekdays: Int, CaseIterable {
    
    case monday = 1, tuesday, wednesday, thursday, friday, saturday, sunday
    
    func getTitle() -> String {
        switch self {
        case .monday:
            return "Понедельник"
        case .tuesday:
            return "Вторник"
        case .wednesday:
            return "Среда"
        case .thursday:
            return "Четверг"
        case .friday:
            return "Пятница"
        case .saturday:
            return "Суббота"
        case .sunday:
            return "Воскресенье"
        }
    }
}
