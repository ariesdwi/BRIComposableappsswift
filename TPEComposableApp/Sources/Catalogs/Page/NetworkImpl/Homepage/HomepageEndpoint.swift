//
//  HomepageEndpoint.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 21/10/25.
//


import Foundation
import TPENetworkingCore

public enum HomepageEndpoint: Endpoint {
    case project(id: String)

    public var baseURL: String {
        "http://172.24.169.113/strapi/api"
    }

    public var path: String {
        switch self {
        case .project(let id):
            return "/homepages/\(id)"
        }
    }

    public var method: HTTPMethod {
        .get
    }

    public var headers: [String: String]? {
        ["Accept": "application/json"]
    }

    public var parameters: [String: Any]? {
        nil
    }

    public var encoding: ParameterEncoding {
        .url
    }
}
