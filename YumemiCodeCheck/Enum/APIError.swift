//
//  APIError.swift
//  YumemiCodeCheck
//
//  Created by 董 亜飛 on 2023/01/05.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case responseError
    case parseError(Error)
    case serverError(Error)
    case badStatus(statusCode: Int)
    case noData
}
