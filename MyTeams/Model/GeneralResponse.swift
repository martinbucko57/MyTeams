//
//  Response.swift
//  MyTeams
//
//  Created by Martin Bucko on 20/12/2021.
//

import Foundation

struct GeneralResponse<T: ResponseType>: Codable {
    var endpoint: String
    var parameters: [String: String]
    var errors: [ResponseError]
    var results: Int
    var paging: Paging?
    var response: [T]
    
    enum CodingKeys: String, CodingKey {
        case endpoint = "get"
        case parameters, errors, results, paging, response
    }
}

struct ResponseError: Codable {
    var time: String
    var bug: String
    var report: String
}

struct Paging: Codable {
    var current: Int
    var total: Int
}
