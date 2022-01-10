//
//  FixtureStatus.swift
//  MyTeams
//
//  Created by Martin Bucko on 08/01/2022.
//

import Foundation

struct League: Codable, Hashable {
    var id: Int
    var name: String
    var country: String?
    var logo: URL?
    var flag: URL?
    var season: Int?
    //var round: String
    var type: String?
    var standings: [[LeagueStanding]]?
}

struct LeagueStanding: Codable, Hashable {
    var rank: Int
    var team: Team
    var points: Int
    //var goalsDiff: Int
    var group: String
    var form: String
    //var status: String
    //var standingDescription: String?
    var allResults: LeagueStandingTeamResult
    //var homeResults: StandingTeamResult
    //var awayResults: StandingTeamResult
    //var update: Date
    
    enum CodingKeys: String, CodingKey {
        case allResults = "all"
        case rank, team, points, group, form
    }
}

struct LeagueStandingTeamResult: Codable, Hashable {
    var played: Int
    var win: Int
    var draw: Int
    var lose: Int
    var goals: LeagueStandingTeamGoals
}

struct LeagueStandingTeamGoals: Codable, Hashable {
    var goalsFor: Int
    var goalsAgainst: Int
    
    enum CodingKeys: String, CodingKey {
        case goalsFor = "for"
        case goalsAgainst = "against"
    }
}
