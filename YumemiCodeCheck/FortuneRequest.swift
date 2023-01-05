//
//  FortuneRequest.swift
//  YumemiCodeCheck
//
//  Created by 董 亜飛 on 2023/01/05.
//

import Foundation

final class FortuneRequest {
    private let url: URL = .init(string: "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud/my_fortune")!
    
    func requestMyFortune(name: String, birthday: Date, bloodType: BloodType) async throws -> FortuneResult {
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
        return result
    }
    
    private func requestBody(name: String, birthday: Date, bloodType: BloodType) -> Data? {
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
