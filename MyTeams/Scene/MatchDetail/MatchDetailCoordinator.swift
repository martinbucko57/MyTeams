//
//  MatchDetailCoordinator.swift
//  MyTeams
//
//  Created by Martin Bucko on 08/01/2022.
//

import UIKit

protocol MatchDetailCoordinatorType {
    func start()
}

class MatchDetailCoordinator: MatchDetailCoordinatorType {
    
    private var rootViewController: UINavigationController
    private weak var currentController: MatchDetailViewController?
    
    let fixtureId: Int
    
    init(rootViewController: UINavigationController, fixtureId: Int) {
        self.rootViewController = rootViewController
        self.fixtureId = fixtureId
    }
    
    func start() {
        let viewModel = MatchDetailViewModel(fixtureId: fixtureId)
        viewModel.coordinator = self
        let controller = MatchDetailViewController.instantiate()
        controller.viewModel = viewModel
        currentController = controller
        rootViewController.pushViewController(controller, animated: true)
    }
}
