//
//  NavigationPath.swift
//  YumemiCodeCheck
//
//  Created by 董 亜飛 on 2023/01/07.
//

import Foundation

enum NavigationPath: Hashable {
    case fortune
    case fortuneDetail(fortuneResult: FortuneResult)
}
