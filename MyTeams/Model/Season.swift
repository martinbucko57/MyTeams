//
//  Season.swift
//  MyTeams
//
//  Created by Martin Bucko on 08/01/2022.
//

import Foundation

struct Season: Codable {
    var year: Int
    var start:String
    var end: String
    var current: Bool
    var coverage: Coverage
}

struct Coverage: Codable {
    //var fixtures: CoverageFixture
    var standings: Bool
    //var players: Bool
    //var topScorers: Bool
    //var topAssists: Bool
    //var topCards: Bool
    //var injuries: Bool
    //var predictions: Bool
    //var odds: Bool
}

//struct CoverageFixture: Codable {
//    var events: Bool
//    var lineups: Bool
//    var statisticsFixtures: Bool
//    var statisticsPlayers: Bool
//}
