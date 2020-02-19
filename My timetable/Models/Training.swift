//
//  Training.swift
//  My timetable
//
//  Created by Васлий Николаев on 17.02.2020.
//  Copyright © 2020 Васлий Николаев. All rights reserved.
//

import RealmSwift

class Training: Object, Decodable {
    
    @objc dynamic var name: String = ""
    @objc dynamic var place: String = ""
    @objc dynamic var teacher_v2: Teacher?
    @objc dynamic var startTime: String = ""
    @objc dynamic var endTime: String = ""
    @objc dynamic var weekDay: Int = 1
    @objc dynamic var pay: Bool = false
    @objc dynamic var color: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name
        case place
        case teacher_v2
        case startTime
        case endTime
        case weekDay
        case pay
        case color
    }
    
     required init(from decoder: Decoder) {
        do {
           let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decode(String.self, forKey: .name)
            place = try container.decode(String.self, forKey: .place)
            startTime = try container.decode(String.self, forKey: .startTime)
            endTime = try container.decode(String.self, forKey: .endTime)
            weekDay = try container.decode(Int.self, forKey: .weekDay)
            pay = try container.decode(Bool.self, forKey: .pay)
            color = try container.decode(String.self, forKey: .color)
            teacher_v2 = try container.decode(Teacher.self, forKey: .teacher_v2)
            
        } catch let error {
            print(error)
        }
        super.init()
    }
    
    required init() {
        super.init()
    }
}

class Teacher: Object, RealmOptionalType, Decodable {
    @objc dynamic var short_name: String = ""
    @objc dynamic var name: String = ""
    
    enum CodingKeys: String, CodingKey {
        case short_name
        case name
    }
    
    required init(from decoder: Decoder) {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            short_name = try container.decode(String.self, forKey: .short_name)
            name = try container.decode(String.self, forKey: .name)
        
        } catch let error {
            print(error)
        }
        super.init()
    }
    
    required init() {
        super.init()
    }
}
