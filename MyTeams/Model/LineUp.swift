//
//  LineUp.swift
//  MyTeams
//
//  Created by Martin Bucko on 08/01/2022.
//

import Foundation

struct LineUp: Codable {
    var team: Team
    var coach: Player
    var formation: String
    var startXI: [Player]
    var substitutes: [Player]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.team = try container.decode(Team.self, forKey: .team)
        self.coach = try container.decode(Player.self, forKey: .coach)
        self.formation = try container.decode(String.self, forKey: .formation)
        self.startXI = try container.decode([[String: Player]].self, forKey: .startXI).flatMap({ $0.values })
        self.substitutes = try container.decode([[String: Player]].self, forKey: .substitutes).flatMap({ $0.values })
    }
}
