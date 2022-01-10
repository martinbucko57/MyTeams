// 
//  TeamListCoordinator.swift
//  MyTeams
//
//  Created by Martin Bucko on 17/12/2021.
//

import UIKit

protocol TeamListCoordinatorType {
    func start()
    func showTeam(team: Team)
    func showSearchController()
}

class TeamListCoordinator: TeamListCoordinatorType {

    var rootViewController: UINavigationController
    private weak var currentController: TeamListViewController?

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = TeamListViewModel()
        viewModel.coordinator = self
        let controller = TeamListViewController.instantiate()
        controller.viewModel = viewModel
        currentController = controller
        rootViewController.pushViewController(controller, animated: true)
    }
    
    func showTeam(team: Team) {
        TeamDetailCoordinator(rootViewController: rootViewController, team: team).start()
    }
    
    func showSearchController() {
        SearchTeamCoordinator(rootViewController: rootViewController).start()
    }
}
