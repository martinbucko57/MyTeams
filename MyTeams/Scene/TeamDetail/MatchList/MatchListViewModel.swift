//
//  MatchListViewModel.swift
//  MyTeams
//
//  Created by Martin Bucko on 01/01/2022.
//

import Foundation

protocol MatchListViewModelInputs {
    func viewDidLoad()
    func leagueListButtonTapped()
    func matchTapped(at indexPath: IndexPath)
}

protocol MatchListViewModelOutputs {
    var didFinishFetching: ((Int?) -> Void)? { get set }
    var isFetching: ((Bool) -> Void)? { get set }
}

protocol MatchListViewModelType {
    var inputs: MatchListViewModelInputs { get set }
    var outputs: MatchListViewModelOutputs { get set }
    
    var matchViewModels: [MatchCellViewModel] { get }
    var selectedLeague: League? { get }
}

class MatchListViewModel: MatchListViewModelType, MatchListViewModelOutputs, MatchListViewModelInputs {
    
    var inputs: MatchListViewModelInputs { get { return self } set{} }
    var outputs: MatchListViewModelOutputs { get { return self } set{} }

    var coordinator: MatchListCoordinatorType?
    
    var didFinishFetching: ((Int?) -> Void)?
    var isFetching: ((Bool) -> Void)?
    
    var matchViewModels: [MatchCellViewModel]
    var selectedLeague: League?

    private var originalMatchList: [ResponseFixture]
    private var leagueList: [League]
    private let team: Team

    init(team: Team) {
        self.team = team
        self.matchViewModels = [MatchCellViewModel]()
        self.originalMatchList = [ResponseFixture]()
        self.leagueList = [League]()
    }
}

extension MatchListViewModel {
    private var actualFixture: Int {
        return matchViewModels
            .firstIndex { Calendar.current.compare($0.date, to: Date(), toGranularity: .day) != .orderedDescending } ?? matchViewModels.lastIndex { _ in true } ?? 0
    }
    
    func viewDidLoad() {
        initFetch()
    }
    
    func leagueListButtonTapped() {
        var leagues = leagueList.sorted { $0.name < $1.name }
        leagues.insert(League(id: 0, name: "All Leagues", country: "", season: 0), at: 0)
        coordinator?.showActionSheet(leagueList: leagues, completion: { [weak self] league in
            self?.selectedLeague = league
            self?.filterFixtures(by: league.id)
            self?.didFinishFetching?(self?.actualFixture)
        })
    }
    
    func matchTapped(at indexPath: IndexPath) {
        let viewModel = matchViewModels[indexPath.row]
        coordinator?.showMatchDetail(for: viewModel.matchId)
    }
    
    private func initFetch() {
        fetchFixtures(for: team.id) { [weak self] fixtures in
            self?.originalMatchList = fixtures
                .sorted { $0.fixture.timestamp > $1.fixture.timestamp }
            self?.matchViewModels = fixtures
                .map { MatchCellViewModel(match: $0) }
                .sorted { $0.date > $1.date }
            self?.leagueList = fixtures
                .map { $0.league }.uniqued()
            self?.didFinishFetching?(self?.actualFixture)
        }
    }
    
    private func fetchFixtures(for teamId: Int, season: String = String(AppConstants.currentSeason), completion: @escaping ([ResponseFixture]) -> Void) {
        isFetching?(true)
        APIService.fetchFixturesForTeam(teamId: teamId, season: season) { [weak self] (result: Result<[ResponseFixture], Error>) in
            switch result {
            case .success(let fixtures):
                completion(fixtures)
            case .failure(let failure):
                print(failure)
            }
            self?.isFetching?(false)
        }
    }
    
    private func filterFixtures(by leagueId: Int) {
        matchViewModels = leagueId == 0         //leagueID = 0 -> ALL LEAGUES
            ? originalMatchList.map { MatchCellViewModel(match: $0) }
            : originalMatchList.filter { $0.league.id == leagueId }.map { MatchCellViewModel(match: $0) }
    }
}
