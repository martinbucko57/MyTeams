//
//  Endpoint.swift
//  MyTeams
//
//  Created by Martin Bucko on 19/12/2021.
//

import Foundation

enum EndpointEnum {
    case teams, fixtures, leagues, standings
}

extension EndpointEnum {
    
    var path: String {
        switch self {
        case .teams: return "/teams"
        case .fixtures: return "/fixtures"
        case .leagues: return "/leagues"
        case .standings: return "/standings"
        }
    }
    
    var endpoint: Endpoint {
        return Endpoint(path: path)
    }
}
