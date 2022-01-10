//
//  StandingsCellViewModel.swift
//  MyTeams
//
//  Created by Martin Bucko on 07/01/2022.
//

import Foundation

class StandingsCellViewModel {
    private let standing: LeagueStanding

    init(standing: LeagueStanding) {
        self.standing = standing
    }
}

extension StandingsCellViewModel {
    var rank: String { "\(standing.rank)." }
    var teamLogoURL: URL? { standing.team.logo }
    var teamName: String { standing.team.name }
    var group: String { standing.group }
    var playedMatches: String { String(standing.allResults.played) }
    var points: String { String(standing.points) }
    var score: String { "\(standing.allResults.goals.goalsFor):\(standing.allResults.goals.goalsAgainst)" }
}
