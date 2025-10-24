//
//  NetworkLogger.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 14/10/25.
//


import Foundation

public protocol NetworkLoggerProtocol {
    func logRequest(_ request: URLRequest)
    func logResponse(data: Data, response: URLResponse)
}

public final class NetworkLogger: NetworkLoggerProtocol {
   
    
    
    private let isEnabled: Bool
    
    public init(isEnabled: Bool = true) {
        self.isEnabled = isEnabled
    }
    
    public func logRequest(_ request: URLRequest) {
        guard isEnabled else { return }
        
        print("🚀 [REQUEST] \(request.httpMethod ?? "GET") \(request.url?.absoluteString ?? "")")
        
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            print("📋 Headers: \(headers)")
        }
        
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("📦 Body: \(bodyString)")
        }
    }
    
    public func logResponse(data: Data, response: URLResponse) {
        guard isEnabled else { return }
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        let statusEmoji = statusCode >= 200 && statusCode < 300 ? "✅" : "❌"
        
        print("\(statusEmoji) [RESPONSE] \(String(describing: (response as? HTTPURLResponse)?.url)) - Status: \(statusCode)")
        
       if let responseString = String(data: data, encoding: .utf8) {
            print("📥 Response: \(responseString)")
        }
    }
    
}
