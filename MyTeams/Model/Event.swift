//
//  Event.swift
//  MyTeams
//
//  Created by Martin Bucko on 08/01/2022.
//

import Foundation

struct Event: Codable {
    var time: EventTime
    var team: Team
    var player1: Player
    var player2: Player
    var type: EventType
    var detail: String
    var comments: String?
    
    enum CodingKeys: String, CodingKey {
        case player1 = "player"
        case player2 = "assist"
        case time, team, type, detail, comments
    }
}

struct EventTime: Codable {
    var elapsed: Int
    var extra: Int?
}

enum EventType: String, Codable {
    case goal = "Goal"
    case card = "Card"
    case substitution = "subst"
    case VAR = "Var"
    case unknown = "unknown"
    
    enum CodingKeys: String, CodingKey {
        case goal, card, substitution, VAR
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        self = EventType(rawValue: string) ?? .unknown
    }
}
