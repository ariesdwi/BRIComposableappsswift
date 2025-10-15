//
//  Endpoint.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 14/10/25.
//

import Foundation

public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var encoding: ParameterEncoding { get }
}

public enum ParameterEncoding {
    case url
    case json
    case formData
}
