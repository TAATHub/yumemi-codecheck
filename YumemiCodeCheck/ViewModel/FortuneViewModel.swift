//
//  ContentViewModel.swift
//  YumemiCodeCheck
//
//  Created by 董 亜飛 on 2023/01/04.
//

import Foundation

@MainActor
protocol FortuneViewModelProtocol: ObservableObject {
    /// 名前
    var name: String { get set }
    /// 生年月日
    var birthday: Date { get set }
    /// 血液型
    var bloodType: BloodType { get set }
    /// ローディング中かどうか
    var isLoading: Bool { get set }
    /// 入力値不正のアラート表示フラグ
    var isInvalidInputAlertPresented: Bool { get set }
    /// エラーアラートの表示フラグ
    var isErrorAlertPresented: Bool { get set }
    
    /// 入力値のバリデーション処理
    /// - Returns: Bool
    func validateInputs() -> Bool
    /// 占うボタン押下時の処理
    func onFortuneButtonTapped() async
}

final class FortuneViewModel: FortuneViewModelProtocol {
    var request: FortuneRequest = .init()
    
    @Published var name: String = ""
    @Published var birthday: Date = Date()
    @Published var bloodType: BloodType = .unkown
    @Published var isLoading: Bool = false
    @Published var isInvalidInputAlertPresented: Bool = false
    @Published var isErrorAlertPresented: Bool = false
    
    func validateInputs() -> Bool {
        return !name.isEmpty && bloodType != .unkown
    }
    
    func onFortuneButtonTapped() async {
        guard validateInputs() else {
            isInvalidInputAlertPresented = true
            return
        }
        
        do {
            defer { isLoading = false }
            isLoading = true
            
            // TODO: resultが返却されたら画面遷移して表示する
            let result: FortuneResult = try await request.requestMyFortune(name: name, birthday: birthday, bloodType: bloodType)
            
        } catch {
            isErrorAlertPresented = true
        }
    }
}
