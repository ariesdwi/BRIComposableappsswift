//
//  NetworkService.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 14/10/25.
//

import Alamofire
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
    
    private let session: Session
    private let logger: NetworkLoggerProtocol?
    
    public init(
        configuration: URLSessionConfiguration = .default,
        logger: NetworkLoggerProtocol? = nil
    ) {
        self.session = Session(configuration: configuration)
        self.logger = logger
    }
    
    public func request<T: Decodable>(
        _ endpoint: Endpoint,
        expecting type: T.Type
    ) async throws -> T {
        let request = try createRequest(from: endpoint)
        
        logger?.logRequest(request)
        
        let response = await session.request(request)
            .validate()
            .serializingDecodable(T.self)
            .response
        
        logger?.logResponse(response)
        
        switch response.result {
        case .success(let value):
            return value
        case .failure(let error):
            throw handleError(error, response: response.response)
        }
    }
    
    public func request(_ endpoint: Endpoint) async throws {
        let request = try createRequest(from: endpoint)
        
        logger?.logRequest(request)
        
        let response = await session.request(request)
            .validate()
            .serializingData()
            .response
        
        logger?.logResponse(response)
        
        if let error = response.error {
            throw handleError(error, response: response.response)
        }
    }
    
    public func upload<T: Decodable>(
        _ endpoint: Endpoint,
        data: Data,
        expecting type: T.Type
    ) async throws -> T {
        let request = try createRequest(from: endpoint)
        
        logger?.logRequest(request)
        
        let response = await session.upload(data, with: request)
            .validate()
            .serializingDecodable(T.self)
            .response
        
        logger?.logResponse(response)
        
        switch response.result {
        case .success(let value):
            return value
        case .failure(let error):
            throw handleError(error, response: response.response)
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
    
    private func handleError(_ error: AFError, response: HTTPURLResponse?) -> APIError {
        if let statusCode = response?.statusCode {
            switch statusCode {
            case 401:
                return .unauthorized
            case 400...499:
                return .statusCode(statusCode)
            case 500...599:
                return .serverError("Server error: \(statusCode)")
            default:
                break
            }
        }
        
        if error.isResponseSerializationError {
            return .decodingError(error)
        }
        
        return .networkError(error)
    }
}
