//
//  StandingListCoordinator.swift
//  MyTeams
//
//  Created by Martin Bucko on 05/01/2022.
//

import UIKit

protocol StandingListCoordinatorType {
    func start() -> UIViewController
    func showActionSheet(leagueList: [League], completion: @escaping (League) -> Void)
}

class StandingListCoordinator: StandingListCoordinatorType {

    private var parentCoordinator: TeamDetailCoordinatorType
    private weak var currentController: StandingListViewController?
    
    private let team: Team

    init(parentCoordinator: TeamDetailCoordinatorType, team: Team) {
        self.parentCoordinator = parentCoordinator
        self.team = team
    }
    
    func start() -> UIViewController {
        let viewModel = StandingListViewModel(team: team)
        viewModel.coordinator = self
        let controller = StandingListViewController.instantiate()
        controller.viewModel = viewModel
        currentController = controller
        return controller
    }
    
    func showActionSheet(leagueList: [League], completion: @escaping (League) -> Void) {
        let alert = UIAlertController(title: "Select league", message: nil, preferredStyle: .actionSheet)
        leagueList.forEach { league in
            alert.addAction(UIAlertAction(title: league.name, style: .default, handler: { _ in
                completion(league)
            }))
        }
        currentController?.present(alert, animated: true)
    }
}
