//
//  Responses.swift
//  MyTeams
//
//  Created by Martin Bucko on 22/12/2021.
//

import Foundation

protocol ResponseType: Codable {}

struct ResponseTeams: ResponseType {
    var team: Team
    var venue: Venue
}

struct ResponseFixture: ResponseType {
    var fixture: Fixture
    var league: League
    var teams: FixtureTeams
    var goals: FixtureScore
    var score: FixtureScoreType
    var events: [Event]?
    var lineups: [LineUp]?
    var statistics: [FixtureTeamStatistics]?
    //var playersStatistics: [PlayerStatistics]?
}

struct ResponseLeague: ResponseType {
    var league: League
    var country: Country
    var seasons: [Season]
}

struct ResponseLeagueStandings: ResponseType {
    var league: League
}
