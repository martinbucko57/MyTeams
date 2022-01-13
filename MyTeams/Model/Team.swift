//
//  Team.swift
//  MyTeams
//
//  Created by Martin Bucko on 08/01/2022.
//

import Foundation

struct Team: Codable, Hashable {
    var id: Int
    var name: String
    var country: String?
    var founded: Int?
    //var national: Bool
    var logo: URL?
    var winner: Bool?
    var isFavourite: Bool?
    var status: TeamStatus?
}

enum TeamStatus: Codable {
    case home, away
}
