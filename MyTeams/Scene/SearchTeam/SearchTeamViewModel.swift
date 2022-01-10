//
//  SearchTeamViewModel.swift
//  MyTeams
//
//  Created by Martin Bucko on 24/12/2021.
//

import Foundation

protocol SearchTeamViewModelInputs {
    func viewDidLoad()
    func viewWillDisappear()
    func teamTapped(at indexPath: IndexPath)
    func searchTriggered(with text: String)
}

protocol SearchTeamViewModelOutputs {
    var didFinishFetching: (() -> Void)? { get set }
    var didRowChange: ((IndexPath) -> Void)? { get set }
}

protocol SearchTeamViewModelType {
    var inputs: SearchTeamViewModelInputs { get set }
    var outputs: SearchTeamViewModelOutputs { get set }
    
    var searchTeamViewModels: [TeamCellViewModel] { get }
}

class SearchTeamViewModel: SearchTeamViewModelType, SearchTeamViewModelInputs, SearchTeamViewModelOutputs {
    var inputs: SearchTeamViewModelInputs { get { return self } set {} }
    var outputs: SearchTeamViewModelOutputs { get { return self } set {} }
    
    var coordinator: SearchTeamCoordinatorType?
    
    var didFinishFetching: (() -> Void)?
    var didRowChange: ((IndexPath) -> Void)?
    
    var searchTeamViewModels: [TeamCellViewModel]
    var favouriteTeams: [Team]
    
    init() {
        self.searchTeamViewModels = [TeamCellViewModel]()
        self.favouriteTeams = [Team]()
    }
}

extension SearchTeamViewModel {
    func viewDidLoad() {
        favouriteTeams = UserDefaults.favouriteTeams
    }
    
    func viewWillDisappear() {
        UserDefaults.favouriteTeams = favouriteTeams
    }
    
    func teamTapped(at indexPath: IndexPath) {
        let viewModel = searchTeamViewModels[indexPath.row]
        viewModel.isFavourite = !viewModel.isFavourite

        if let index = favouriteTeams.map({ $0.id }).firstIndex(of: viewModel.teamId) {
            favouriteTeams.remove(at: index)
        } else {
            favouriteTeams.append(Team(id: viewModel.teamId, name: viewModel.teamName, logo: viewModel.teamLogo, isFavourite: true))
        }
        
        self.didRowChange?(indexPath)
    }
    
    func searchTriggered(with text: String) {
        searchTeams(by: text) { [weak self] teams in
            self?.searchTeamViewModels = teams.map {
                let teamViewModel = TeamCellViewModel(team: $0)
                if let self = self {
                    teamViewModel.isFavourite = self.favouriteTeams.map({ $0.id }).contains($0.id)
                }
                return teamViewModel
            }
            self?.didFinishFetching?()
        }
    }
    
    private func searchTeams(by teamName: String, completion: @escaping ([Team]) -> Void) {
        APIService.searchTeamByName(teamName: teamName) { (result: Result<[Team], Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let teams):
                    completion(teams)
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
}
