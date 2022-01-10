//
//  TeamDetailViewModel.swift
//  MyTeams
//
//  Created by Martin Bucko on 29/12/2021.
//

import Foundation

protocol TeamDetailViewModelInputs {
    func viewDidLoad()
    func segmentValueChanged(selectedIndex: Int)
    func favouriteTapped()
}

protocol TeamDetailViewModelOutputs {
    var didUpdateFavor: (() -> Void)? { get set }
}

protocol TeamDetailViewModelType {
    var inputs: TeamDetailViewModelInputs { get set }
    var outputs: TeamDetailViewModelOutputs { get set }
    
    var isFavourite: Bool { get }
    var teamId: Int { get }
    var teamLogo: URL? { get }
    var teamName: String { get }
}

class TeamDetailViewModel: TeamDetailViewModelType, TeamDetailViewModelOutputs, TeamDetailViewModelInputs {
    
    var inputs: TeamDetailViewModelInputs { get { return self } set{} }
    var outputs: TeamDetailViewModelOutputs { get { return self } set{} }

    var coordinator: TeamDetailCoordinatorType?
    
    var didUpdateFavor: (() -> Void)?
    
    private var team: Team

    init(team: Team) {
        self.team = team
    }
}

extension TeamDetailViewModel {
    var isFavourite: Bool {
        get { team.isFavourite ?? false }
        set { team.isFavourite = newValue }
    }
    var teamId: Int { team.id }
    var teamLogo: URL? { team.logo }
    var teamName: String { team.name }
    
    func viewDidLoad() {
        segmentValueChanged(selectedIndex: 0)
    }
    
    func segmentValueChanged(selectedIndex: Int) {
        switch selectedIndex {
        case 0:
            coordinator?.showMatches()
        case 1:
            coordinator?.showStandings()
        default:
            break
        }
    }
    
    func favouriteTapped() {
        var favouriteTeams = UserDefaults.favouriteTeams
        isFavourite = !isFavourite
        if let index = favouriteTeams.map({ $0.id }).firstIndex(of: teamId) {
            favouriteTeams.remove(at: index)
        } else {
            favouriteTeams.append(team)
        }
        UserDefaults.favouriteTeams = favouriteTeams
        didUpdateFavor?()
    }
}
