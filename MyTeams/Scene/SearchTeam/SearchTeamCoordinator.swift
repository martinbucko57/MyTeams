//
//  SearchTeamCoordinator.swift
//  MyTeams
//
//  Created by Martin Bucko on 24/12/2021.
//

import UIKit

protocol SearchTeamCoordinatorType {
    func start()
}

class SearchTeamCoordinator: SearchTeamCoordinatorType {

    private var rootViewController: UINavigationController
    private weak var currentController: SearchTeamViewController?

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let viewModel = SearchTeamViewModel()
        viewModel.coordinator = self
        let controller = SearchTeamViewController.instantiate()
        controller.viewModel = viewModel
        currentController = controller
        rootViewController.pushViewController(controller, animated: true)
    }
}
