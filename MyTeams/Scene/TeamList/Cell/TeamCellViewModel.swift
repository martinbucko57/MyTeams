//
//  TeamViewModel.swift
//  MyTeams
//
//  Created by Martin Bucko on 17/12/2021.
//

import Foundation

class TeamCellViewModel {
    private var team: Team

    init(team: Team) {
        self.team = team
    }
}

extension TeamCellViewModel {
    var isFavourite: Bool {
        get { team.isFavourite ?? false }
        set { team.isFavourite = newValue }
    }
   
    var teamId: Int { team.id }
    var teamLogo: URL? { team.logo }
    var teamName: String { team.name }
}

