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
    /// 入力値不正のアラート表示フラグ
    var isInvalidInputAlertPresented: Bool { get set }
    
    /// 入力値のバリデーション処理
    /// - Returns: Bool
    func validateInputs() -> Bool
    /// 占うボタン押下時の処理
    func onFortuneButtonTapped() async
}

final class FortuneViewModel: FortuneViewModelProtocol {
    @Published var name: String = ""
    @Published var birthday: Date = Date()
    @Published var bloodType: BloodType = .unkown
    @Published var isInvalidInputAlertPresented: Bool = false
    
    func validateInputs() -> Bool {
        return !name.isEmpty && bloodType != .unkown
    }
    
    func onFortuneButtonTapped() async {
        guard validateInputs() else {
            isInvalidInputAlertPresented = true
            return
        }
        // TODO: リクエスト層に切り出す
        
        do {
            guard let url = URL(string: "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud/my_fortune") else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("v1", forHTTPHeaderField: "API-Version")
            
            if let body = requestBody(name: name, birthday: birthday, bloodType: bloodType) {
                request.httpBody = body
            }
            
            // TODO: ローディング表示
            let (data, urlResponse) = try await URLSession.shared.data(for: request)
            // TODO: レスポンスステータスに応じてもエラー表示
            let result: FortuneResult = try JSONDecoder().decode(FortuneResult.self, from: data)
            print(result)
        } catch let error {
            // TODO: エラー表示
            print(error)
        }
    }
    
    func requestBody(name: String, birthday: Date, bloodType: BloodType) -> Data? {
        let birthdayDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: birthday)
        let todayDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        
        let fortune: Fortune = .init(name: name,
                                     birthday: Day(year: birthdayDateComponents.year!,
                                                   month: birthdayDateComponents.month!,
                                                   day: birthdayDateComponents.day!),
                                     blood_type: bloodType.rawValue,
                                     today: Day(year: todayDateComponents.year!,
                                                month: todayDateComponents.month!,
                                                day: todayDateComponents.day!))
        return try? JSONEncoder().encode(fortune)
    }
}
