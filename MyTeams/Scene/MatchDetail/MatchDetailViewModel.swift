//
//  MatchDetailViewModel.swift
//  MyTeams
//
//  Created by Martin Bucko on 08/01/2022.
//

import Foundation

protocol MatchDetailViewModelInputs {
    func viewDidLoad()
    func segmentValueChanged(selectedIndex: Int)
}

protocol MatchDetailViewModelOutputs {
    var didFinishFetching: (() -> Void)? { get set }
    var isFetching: ((Bool) -> Void)? { get set }
}

protocol MatchDetailViewModelType {
    var inputs: MatchDetailViewModelInputs { get set }
    var outputs: MatchDetailViewModelOutputs { get set }
    
    var teamHomeName: String { get }
    var teamAwayName: String { get }
    var teamHomeURL: URL? { get }
    var teamAwayURL: URL? { get }
    var matchDate: String { get }
    var matchScore: String { get }
    var matchStatus: String? { get }
    var timeElapsed: String? { get }
}

class MatchDetailViewModel: MatchDetailViewModelType, MatchDetailViewModelOutputs, MatchDetailViewModelInputs {
    
    var inputs: MatchDetailViewModelInputs { get { return self } set{} }
    var outputs: MatchDetailViewModelOutputs { get { return self } set{} }

    var coordinator: MatchDetailCoordinatorType?
    
    var didFinishFetching: (() -> Void)?
    var isFetching: ((Bool) -> Void)?
    
    private let fixtureId: Int
    private var match: ResponseFixture?

    init(fixtureId: Int) {
        self.fixtureId = fixtureId
    }
}

extension MatchDetailViewModel {
    var teamHomeName: String { match?.teams.home.name ?? ""}
    var teamAwayName: String { match?.teams.away.name ?? ""}
    var teamHomeURL: URL? { match?.teams.home.logo }
    var teamAwayURL: URL? { match?.teams.away.logo }
    var matchDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy\nHH:mm"
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(match?.fixture.timestamp ?? 0)))
    }
    var matchScore: String { "\(match?.goals.home?.description ?? "") : \(match?.goals.away?.description ?? "")" }
    var matchStatus: String? { match?.fixture.status.long }
    var timeElapsed: String? {
        guard let timeElapsed = match?.fixture.status.elapsed else { return nil }
        return "\(timeElapsed)'"
    }
    
    func viewDidLoad() {
        initFetch()
    }
    
    func segmentValueChanged(selectedIndex: Int) {
        switch selectedIndex {
        case 0:
            let events = match?.events?.map { (event: Event) -> Event in
                var newEvent = event
                if event.team.id == match?.teams.home.id {
                    newEvent.team.status = .home
                } else {
                    newEvent.team.status = .away
                }
                return newEvent
            }
            coordinator?.showEvents(eventList: events ?? [])
        case 1:
            guard match?.lineups?.count == 2 else { return }
            let (homeLineUp, awayLineUp) = match?.lineups?.first?.team.id == match?.teams.home.id
                ? (match?.lineups?.first, match?.lineups?.last)
                : (match?.lineups?.last, match?.lineups?.first)
            
            guard let homeLineUp = homeLineUp, let awayLineUp = awayLineUp else { return }
            coordinator?.showLineUps(homeLineUp: homeLineUp, awayLineUp: awayLineUp)
        default:
            break
        }
    }

    private func initFetch() {
        fetchMatch(for: fixtureId) { [weak self] match in
            self?.match = match
            self?.didFinishFetching?()
            DispatchQueue.main.async {
                self?.segmentValueChanged(selectedIndex: 0)
            }
        }
    }
    
    private func fetchMatch(for fixtureId: Int, completion: @escaping (ResponseFixture?) -> Void) {
        isFetching?(true)
        APIService.fetchFixture(fixtureId: fixtureId) { [weak self] (result: Result<ResponseFixture?, Error>) in
            switch result {
            case .success(let fixture):
                completion(fixture)
            case .failure(let failure):
                print(failure)
            }
            self?.isFetching?(false)
        }
    }
}
