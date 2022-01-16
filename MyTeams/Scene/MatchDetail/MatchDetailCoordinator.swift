//
//  MatchDetailCoordinator.swift
//  MyTeams
//
//  Created by Martin Bucko on 08/01/2022.
//

import UIKit

protocol MatchDetailCoordinatorType {
    func start()
    func showEvents(eventList: [Event])
    func showLineUps(homeLineUp: LineUp, awayLineUp: LineUp)
}

class MatchDetailCoordinator: MatchDetailCoordinatorType {
    
    private var rootViewController: UINavigationController
    private weak var currentController: MatchDetailViewController?
    private weak var currentChildController: UIViewController?
    private var childControllers: Set<UIViewController>
    
    let fixtureId: Int
    
    init(rootViewController: UINavigationController, fixtureId: Int) {
        self.rootViewController = rootViewController
        self.fixtureId = fixtureId
        self.childControllers = []
    }
    
    func start() {
        let viewModel = MatchDetailViewModel(fixtureId: fixtureId)
        viewModel.coordinator = self
        let controller = MatchDetailViewController.instantiate()
        controller.viewModel = viewModel
        currentController = controller
        rootViewController.pushViewController(controller, animated: true)
    }
    
    func showEvents(eventList: [Event]) {
        if let currentChildController = currentChildController {
            removeChildViewController(viewController: currentChildController)
        }
        let newChildController = childControllers.first(where: { $0 is EventListViewController }) ?? EventListCoordinator(parentCoordinator: self, eventList: eventList).start()
        addChildViewController(viewController: newChildController)
    }
    
    func showLineUps(homeLineUp: LineUp, awayLineUp: LineUp) {
        if let currentChildController = currentChildController {
            removeChildViewController(viewController: currentChildController)
        }
        let newChildController = childControllers.first(where: { $0 is LineUpListViewController }) ?? LineUpListCoordinator(parentCoordinator: self, homeLineUp: homeLineUp, awayLineUp: awayLineUp).start()
        addChildViewController(viewController: newChildController)
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
