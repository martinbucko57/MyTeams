// 
//  TeamListViewModel.swift
//  MyTeams
//
//  Created by Martin Bucko on 17/12/2021.
//

import Foundation

protocol TeamListViewModelInputs {
    func viewDidAppear()
    func teamTapped(at indexPath: IndexPath)
    func addTapped()
}

protocol TeamListViewModelOutputs {
    var didFinishFetching: (() -> Void)? { get set }
}

protocol TeamListViewModelType {
    var inputs: TeamListViewModelInputs { get set }
    var outputs: TeamListViewModelOutputs { get set }
    
    var teamViewModels: [TeamCellViewModel] { get }
}

class TeamListViewModel: TeamListViewModelType, TeamListViewModelOutputs, TeamListViewModelInputs {
    var inputs: TeamListViewModelInputs { get { return self } set{} }
    var outputs: TeamListViewModelOutputs { get { return self } set{} }

    var coordinator: TeamListCoordinatorType?
    
    var didFinishFetching: (() -> Void)?
    
    var teamViewModels: [TeamCellViewModel]

    init() {
        self.teamViewModels = [TeamCellViewModel]()
    }
}

extension TeamListViewModel {
    func viewDidAppear() {
        fetchFavouriteTeams()
    }
    
    func teamTapped(at indexPath: IndexPath) {
        let viewModel = teamViewModels[indexPath.row]
        let team = Team(id: viewModel.teamId, name: viewModel.teamName, logo: viewModel.teamLogo, isFavourite: viewModel.isFavourite)
        coordinator?.showTeam(team: team)
    }
    
    func addTapped() {
        coordinator?.showSearchController()
    }
    
    func fetchFavouriteTeams() {
        DispatchQueue.global().async { [weak self] in
            self?.teamViewModels = UserDefaults.favouriteTeams
                .map { TeamCellViewModel(team: $0) }
                .sorted { $0.teamName < $1.teamName }
            
            self?.didFinishFetching?()
        }
    }
}
