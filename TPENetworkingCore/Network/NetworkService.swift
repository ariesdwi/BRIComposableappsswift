//
//  NetworkService.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 14/10/25.
//

import Foundation

public protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        _ endpoint: Endpoint,
        expecting type: T.Type
    ) async throws -> T
    
    func request(
        _ endpoint: Endpoint
    ) async throws
    
    func upload<T: Decodable>(
        _ endpoint: Endpoint,
        data: Data,
        expecting type: T.Type
    ) async throws -> T
}


public final class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession
    private let logger: NetworkLoggerProtocol?
    
    public init(
        configuration: URLSessionConfiguration = .default,
        logger: NetworkLoggerProtocol? = nil
    ) {
        self.session = URLSession(configuration: configuration)
        self.logger = logger
    }
    
    public func request<T: Decodable>(
        _ endpoint: Endpoint,
        expecting type: T.Type
    ) async throws -> T {
        let request = try createRequest(from: endpoint)
        
        logger?.logRequest(request)
        
        let (data, response) = try await session.data(for: request)
        logger?.logResponse(data: data, response: response)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        try validateStatusCode(httpResponse.statusCode)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
        
    }
    
    public func request(_ endpoint: Endpoint) async throws {
        let request = try createRequest(from: endpoint)
        
        logger?.logRequest(request)
        
        let (data, response) = try await session.data(for: request)
            
        logger?.logResponse(data: data, response: response)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        try validateStatusCode(httpResponse.statusCode)
       
       
    }
    
    public func upload<T: Decodable>(
        _ endpoint: Endpoint,
        data: Data,
        expecting type: T.Type
    ) async throws -> T {
        let request = try createRequest(from: endpoint)
        
        logger?.logRequest(request)
        
        let (responseData, response) = try await session.upload(for: request, from: data)
        logger?.logResponse(data: responseData, response: response)
        guard let httpResponse = response as? HTTPURLResponse else {
                   throw APIError.invalidResponse
               }
               
               try validateStatusCode(httpResponse.statusCode)
               
               do {
                   let decoder = JSONDecoder()
                   return try decoder.decode(T.self, from: responseData)
               } catch {
                   throw APIError.decodingError(error)
               }
        
    }
    
    private func createRequest(from endpoint: Endpoint) throws -> URLRequest {
        let url = try createURL(from: endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        // Set headers
        endpoint.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Set parameters
        if let parameters = endpoint.parameters {
            switch endpoint.encoding {
            case .url:
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                request.url = components?.url
                
            case .json:
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .formData:
                let formData = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
                request.httpBody = formData.data(using: .utf8)
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            }
        }
        
        return request
    }
    
    private func createURL(from endpoint: Endpoint) throws -> URL {
        let urlString = endpoint.baseURL + endpoint.path
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        return url
    }
    
    
    private func validateStatusCode(_ statusCode: Int) throws {
           switch statusCode {
           case 200...299:
               return // Success
           case 401:
               throw APIError.unauthorized
           case 400...499:
               throw APIError.statusCode(statusCode)
           case 500...599:
               throw APIError.serverError("Server error: \(statusCode)")
           default:
               throw APIError.statusCode(statusCode)
           }
       }
}
