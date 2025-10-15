//
//  APIError.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 14/10/25.
//

import Foundation

public enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case decodingError(Error)
    case networkError(Error)
    case unauthorized
    case serverError(String)
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .statusCode(let code):
            return "Server returned status code: \(code)"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .unauthorized:
            return "Unauthorized access"
        case .serverError(let message):
            return "Server error: \(message)"
        }
    }
}
