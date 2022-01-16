//
//  LineUpListViewModel.swift
//  MyTeams
//
//  Created by Martin Bucko on 14/01/2022.
//

import Foundation

protocol LineUpListViewModelInputs {}

protocol LineUpListViewModelOutputs {}

protocol LineUpListViewModelType {
    var inputs: LineUpListViewModelInputs { get set }
    var outputs: LineUpListViewModelOutputs { get set }
    
    var lineUpViewModels: KeyValuePairs<String, [LineUpCellViewModel]> { get }
}

class LineUpListViewModel: LineUpListViewModelType, LineUpListViewModelOutputs, LineUpListViewModelInputs {
    
    var inputs: LineUpListViewModelInputs { get { return self } set{} }
    var outputs: LineUpListViewModelOutputs { get { return self } set{} }

    var coordinator: LineUpListCoordinatorType?
    
    var lineUpViewModels: KeyValuePairs<String, [LineUpCellViewModel]>

    private let homeLineUp: LineUp
    private let awayLineUp: LineUp

    init(homeLineUp: LineUp, awayLineUp: LineUp) {
        self.homeLineUp = homeLineUp
        self.awayLineUp = awayLineUp
        self.lineUpViewModels = [
            "Start XI": LineUpListViewModel.parseLineUp(homePlayers: homeLineUp.startXI, awayPlayers: awayLineUp.startXI),
            "Substitutes": LineUpListViewModel.parseLineUp(homePlayers: homeLineUp.substitutes, awayPlayers: awayLineUp.substitutes),
            "Coach": LineUpListViewModel.parseLineUp(homePlayers: [homeLineUp.coach], awayPlayers: [awayLineUp.coach])
        ]
    }
}

extension LineUpListViewModel {
    private static func parseLineUp(homePlayers: [Player], awayPlayers: [Player]) -> [LineUpCellViewModel] {
        var cellViewModels = [LineUpCellViewModel]()
        for index in 0..<max(homePlayers.count, awayPlayers.count) {
            cellViewModels.append(LineUpCellViewModel(homePlayer: homePlayers[safe: index], awayPlayer: awayPlayers[safe: index]))
        }
        return cellViewModels
    }
}
