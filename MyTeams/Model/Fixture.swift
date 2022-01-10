//
//  Fixture.swift
//  MyTeams
//
//  Created by Martin Bucko on 08/01/2022.
//

import Foundation

struct Fixture: Codable {
    var id: Int
    var referee: String?
    //var timezone: String
    //var date: Date
    var timestamp: Int
    //var periods: Periods
    var venue: Venue
    var status: FixtureStatus
}

struct FixtureStatus: Codable {
    var long: String
    var short: String
    var elapsed: Int?
}

struct FixtureTeams: Codable {
    var home: Team
    var away: Team
}

struct FixtureScore: Codable {
    var home: Int?
    var away: Int?
}

struct FixtureScoreType: Codable {
    var halftime: FixtureScore
    var fulltime: FixtureScore
    var extratime: FixtureScore
    var penalty: FixtureScore
}

struct FixtureTeamStatistics: Codable {
    var team: Team
    var statistics: [FixtureStatistic]
}

struct FixtureStatistic: Codable {
    var type: String?
    var value: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try? container.decode(String.self, forKey: .type)
        if let value = try? container.decode(Int.self, forKey: .value) {
            self.value = String(value)
        }
        else if let value = try? container.decode(String.self, forKey: .value) {
            self.value = value
        }
    }
}
