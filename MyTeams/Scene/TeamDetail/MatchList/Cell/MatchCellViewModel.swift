//
//  MatchViewModel.swift
//  MyTeams
//
//  Created by Martin Bucko on 01/01/2022.
//

import Foundation

class MatchCellViewModel {
    private let match: ResponseFixture

    init(match: ResponseFixture) {
        self.match = match
    }
}

extension MatchCellViewModel {
    var date: Date { Date(timeIntervalSince1970: TimeInterval(match.fixture.timestamp)) }
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM."
        return dateFormatter.string(from: date)
    }
    
    var matchId: Int { match.fixture.id }
    var logoHomeURL: URL? { match.teams.home.logo }
    var logoAwayURL: URL? { match.teams.away.logo }
    var nameHome: String { match.teams.home.name }
    var nameAway: String { match.teams.away.name }
    var scoreHome: String { match.goals.home?.description ?? ""}
    var scoreAway: String { match.goals.away?.description ?? ""}
}
