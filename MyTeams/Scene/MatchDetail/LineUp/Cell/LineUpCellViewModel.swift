//
//  LineUpCellViewModel.swift
//  MyTeams
//
//  Created by Martin Bucko on 14/01/2022.
//

import Foundation

class LineUpCellViewModel {
    private let homePlayer: Player?
    private let awayPlayer: Player?

    init(homePlayer: Player?, awayPlayer: Player?) {
        self.homePlayer = homePlayer
        self.awayPlayer = awayPlayer
    }
}

extension LineUpCellViewModel {
    var homePlayerName: String { homePlayer?.name ?? "" }
    var awayPlayerName: String { awayPlayer?.name ?? "" }
    var homePlayerNumber: String { homePlayer?.number?.description ?? "" }
    var awayPlayerNumber: String { awayPlayer?.number?.description ?? "" }
}
