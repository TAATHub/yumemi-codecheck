//
//  FortuneRequest.swift
//  YumemiCodeCheck
//
//  Created by 董 亜飛 on 2023/01/05.
//

import Foundation

final class FortuneRequest {
    private let url: URL = .init(string: "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud/my_fortune")!
    
    /// 都道府県占いのリクエストを行う
    /// - Parameters:
    ///   - name: 名前
    ///   - birthday: 生年月日
    ///   - bloodType: 血液型
    /// - Returns: 占い結果
    func requestMyFortune(name: String, birthday: Date, bloodType: BloodType) async throws -> FortuneResult {   // FIXME: 返却型をResult<FortuneResult, APIError>に変更する
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("aaa", forHTTPHeaderField: "API-Version")
        
        // リクエストボディを作成して付与する
        if let body = requestBody(name: name, birthday: birthday, bloodType: bloodType) {
            request.httpBody = body
        }
        
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: request)
            
            // HTTPステータスを取得できない場合は、レスポンスエラー
            guard let httpStatus = urlResponse as? HTTPURLResponse else {
                throw APIError.responseError
            }
            
            switch httpStatus.statusCode {
            case 200 ..< 400:
                // 200,300台の場合は、デコードを行う
                guard let result: FortuneResult = try? JSONDecoder().decode(FortuneResult.self, from: data) else {
                    // デコード失敗の場合は、データなしエラー
                    throw APIError.noData
                }
                return result
            case 400... :
                // 400台の場合は、Badステータスエラー
                throw APIError.badStatus(statusCode: httpStatus.statusCode)
            default:
                fatalError()
                break
            }
        } catch {
            // それ以外の場合は、サーバーエラー
            throw APIError.serverError(error)
        }
    }
    
    /// リクエスストボディを作成する
    /// - Parameters:
    ///   - name: 名前
    ///   - birthday: 生年月日
    ///   - bloodType: 血液型
    /// - Returns: Data?
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
