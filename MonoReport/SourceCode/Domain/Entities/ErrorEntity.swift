//
//  ErrorEntity.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import Foundation

// MARK: - ErrorEntity
struct ErrorEntity: Error {
  let code: ErrorCode
  let description: String
}

// MARK: - ErrorCode
enum ErrorCode: Int, Codable {
    case ok = 200
    case unauthenticated = 401
    case actionIsUnauthorized = 403
    case requestNotFound = 404
    case unsupportedMethods = 405
    case incorrectParameter = 422
    case serverError
    case downloadError
    case unknown
}
