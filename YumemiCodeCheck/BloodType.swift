//
//  BloodType.swift
//  YumemiCodeCheck
//
//  Created by 董 亜飛 on 2023/01/04.
//

import Foundation

enum BloodType: String {
    case unkown
    case a
    case b
    case o
    case ab
    
    func typeText() -> String {
        switch self {
        case .a, .b, .o, .ab:
            return self.rawValue.uppercased()
        default:
            return "不明"
        }
    }
}
