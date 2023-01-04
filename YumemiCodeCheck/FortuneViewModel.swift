//
//  ContentViewModel.swift
//  YumemiCodeCheck
//
//  Created by 董 亜飛 on 2023/01/04.
//

import Foundation

@MainActor
protocol FortuneViewModelProtocol: ObservableObject {
    var name: String { get set }
    var birthday: Date { get set }
    var bloodType: BloodType { get set }
    
    func onFortuneButtonTapped()
}

final class FortuneViewModel: FortuneViewModelProtocol {
    @Published var name: String = ""
    @Published var birthday: Date = Date()
    @Published var bloodType: BloodType = .unkown
    
    func onFortuneButtonTapped() {
        // TODO: バリデーション処理
        // TODO: APIリクエスト
        print("名前: \(name), 生年月日: \(birthday), 血液型: \(bloodType)")
    }
}
