//
//  TeamDetailCoordinator.swift
//  MyTeams
//
//  Created by Martin Bucko on 29/12/2021.
//

import UIKit

protocol TeamDetailCoordinatorType {
    func start()
    func showMatches()
    func showStandings()
    func showMatchDetail(for fixtureId: Int)
}

class TeamDetailCoordinator: TeamDetailCoordinatorType {

    private var rootViewController: UINavigationController
    private weak var currentController: TeamDetailViewController?
    private weak var currentChildController: UIViewController?
    private var childControllers: Set<UIViewController> = []
    private let team: Team

    init(rootViewController: UINavigationController, team: Team) {
        self.rootViewController = rootViewController
        self.team = team
    }
    
    func start() {
        let viewModel = TeamDetailViewModel(team: team)
        viewModel.coordinator = self
        let controller = TeamDetailViewController.instantiate()
        controller.viewModel = viewModel
        currentController = controller
        rootViewController.pushViewController(controller, animated: true)
    }
    
    func showMatches() {
        if let currentChildController = currentChildController {
            removeChildViewController(viewController: currentChildController)
        }
        let newChildController = childControllers.first(where: { $0 is MatchListViewController }) ?? MatchListCoordinator(parentCoordinator: self, team: team).start()
        addChildViewController(viewController: newChildController)
    }
    
    func showStandings() {
        if let currentChildController = currentChildController {
            removeChildViewController(viewController: currentChildController)
        }
        let newChildController = childControllers.first(where: { $0 is StandingListViewController }) ?? StandingListCoordinator(parentCoordinator: self, team: team).start()
        addChildViewController(viewController: newChildController)
    }
    
    func showMatchDetail(for fixtureId: Int) {
        MatchDetailCoordinator(rootViewController: rootViewController, fixtureId: fixtureId).start()
    }
    
    private func addChildViewController(viewController: UIViewController) {
        guard let currentController = currentController else { return }
        currentController.addChild(viewController)
        currentController.containerView.addSubview(viewController.view)
        viewController.view.frame = currentController.containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: currentController)
        currentChildController = viewController
        childControllers.insert(viewController)
    }
    
    private func removeChildViewController(viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}
