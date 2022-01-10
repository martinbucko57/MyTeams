//
//  StandingListViewModel.swift
//  MyTeams
//
//  Created by Martin Bucko on 05/01/2022.
//

import Foundation

protocol StandingListViewModelInputs {
    func viewDidLoad()
    func leagueListButtonTapped()
}

protocol StandingListViewModelOutputs {
    var didFinishFetching: (() -> Void)? { get set }
    var isFetching: ((Bool) -> Void)? { get set }
}

protocol StandingListViewModelType {
    var inputs: StandingListViewModelInputs { get set }
    var outputs: StandingListViewModelOutputs { get set }
    
    var standingsViewModels: [StandingsCellViewModel] { get }
    var selectedLeague: League? { get }
}

class StandingListViewModel: StandingListViewModelType, StandingListViewModelOutputs, StandingListViewModelInputs {
    var inputs: StandingListViewModelInputs { get { return self } set{} }
    var outputs: StandingListViewModelOutputs { get { return self } set{} }

    var coordinator: StandingListCoordinatorType?
    
    var didFinishFetching: (() -> Void)?
    var isFetching: ((Bool) -> Void)?
    
    var standingsViewModels: [StandingsCellViewModel]
    var selectedLeague: League?

    private var leagueList: [League]
    private let team: Team

    init(team: Team) {
        self.team = team
        self.standingsViewModels = [StandingsCellViewModel]()
        self.leagueList = [League]()
    }
}

extension StandingListViewModel {
    func viewDidLoad() {
        initFetch()
    }
    
    func leagueListButtonTapped() {
        coordinator?.showActionSheet(leagueList: leagueList.sorted { $0.name < $1.name }, completion: { [weak self] league in
            self?.selectedLeague = league
            self?.isFetching?(true)
            self?.fetchLeagueStandings(for: league.id, completion: { standings in
                self?.selectedLeague?.standings = standings
                self?.standingsViewModels = standings?
                    .first(where: { $0.contains(where: { $0.team.id == self?.team.id }) })?
                    .compactMap { StandingsCellViewModel(standing: $0) } ?? []
                self?.isFetching?(false)
                self?.didFinishFetching?()
            })
        })
    }
    
    func fetchLeagueList(for teamId: Int, completion: @escaping ([League]) -> Void) {
        APIService.fetchLeaguesForTeam(teamId: teamId, season: String(AppConstants.currentSeason)) { (result: Result<[League], Error>) in
            switch result {
            case .success(let leagues):
                completion(leagues)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchLeagueStandings(for leagueId: Int, completion: @escaping ([[LeagueStanding]]?) -> Void) {
        APIService.fetchStandingsForLeague(leagueId: leagueId, season: String(AppConstants.currentSeason)) { (result: Result<[[LeagueStanding]], Error>) in
            switch result {
            case .success(let standings):
                completion(standings)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func initFetch() {
        isFetching?(true)
        fetchLeagueList(for: team.id) { [weak self] leagues in
            self?.leagueList = leagues
            self?.selectedLeague = leagues.first(where: { $0.type == "League" })
                ?? leagues.sorted { $0.name < $1.name }.first
            guard let selectedLeague = self?.selectedLeague else { self?.isFetching?(false); return }
            self?.fetchLeagueStandings(for: selectedLeague.id) { [weak self] standings in
                self?.selectedLeague?.standings = standings
                self?.standingsViewModels = standings?
                    .first(where: { $0.contains(where: { $0.team.id == self?.team.id }) })?
                    .compactMap { StandingsCellViewModel(standing: $0) } ?? []
                self?.isFetching?(false)
                self?.didFinishFetching?()
            }
        }
    }
}
