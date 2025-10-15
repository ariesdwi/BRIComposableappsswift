//
//  Untitled.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 14/10/25.
//

import Foundation

public struct NetworkConfiguration {
    public let baseURL: String
    public let timeoutInterval: TimeInterval
    public let additionalHeaders: [String: String]
    
    public init(
        baseURL: String,
        timeoutInterval: TimeInterval = 30.0,
        additionalHeaders: [String: String] = [:]
    ) {
        self.baseURL = baseURL
        self.timeoutInterval = timeoutInterval
        self.additionalHeaders = additionalHeaders
    }
}

public final class NetworkConfigurationManager {
    public static let shared = NetworkConfigurationManager()
    
    private var configurations: [String: NetworkConfiguration] = [:]
    
    private init() {}
    
    public func registerConfiguration(_ configuration: NetworkConfiguration, for environment: String) {
        configurations[environment] = configuration
    }
    
    public func configuration(for environment: String) -> NetworkConfiguration? {
        return configurations[environment]
    }
}
