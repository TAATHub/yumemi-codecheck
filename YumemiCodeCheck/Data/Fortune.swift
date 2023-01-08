//
//  Fortune.swift
//  YumemiCodeCheck
//
//  Created by 董 亜飛 on 2023/01/04.
//

import Foundation

struct Fortune: Codable {
    var name: String
    var birthday: Day
    var blood_type: String
    var today: Day
}

struct Day: Codable {
    var year: Int
    var month: Int
    var day: Int
}

struct FortuneResult: Codable, Hashable {
    var name: String
    var capital: String
    var brief: String
}
