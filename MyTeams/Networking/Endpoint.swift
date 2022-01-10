//
//  Endpoint.swift
//  MyTeams
//
//  Created by Martin Bucko on 20/12/2021.
//

import Foundation

struct Endpoint {
    private let baseURL = EndpointConstants.baseURL
    
    var httpMethod: String
    var headers: [String: String]?
    var parameters: [String: String]?
    var path: String
    
    init(httpMethod: String = "GET", headers: [String: String]? = [EndpointConstants.xRapidapiKey: EndpointConstants.xRapidapiValue], parameters: [String: String]? = nil, path: String) {
        self.httpMethod = httpMethod
        self.headers = headers
        self.parameters = parameters
        self.path = path
    }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        components?.queryItems = parameters?.map { (key, value) in
           URLQueryItem(name: key, value: value)
        }
        return components?.url
    }
}
