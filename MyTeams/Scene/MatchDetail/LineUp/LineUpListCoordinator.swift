//
//  LineUpListCoordinator.swift
//  MyTeams
//
//  Created by Martin Bucko on 14/01/2022.
//

import UIKit

protocol LineUpListCoordinatorType {
    func start() -> UIViewController
}

class LineUpListCoordinator: LineUpListCoordinatorType {
    
    private var parentCoordinator: MatchDetailCoordinatorType
    private weak var currentController: LineUpListViewController?
    
    private let homeLineUp: LineUp
    private let awayLineUp: LineUp
    
    init(parentCoordinator: MatchDetailCoordinatorType, homeLineUp: LineUp, awayLineUp: LineUp) {
        self.parentCoordinator = parentCoordinator
        self.homeLineUp = homeLineUp
        self.awayLineUp = awayLineUp
    }
    
    func start() -> UIViewController {
        let viewModel = LineUpListViewModel(homeLineUp: homeLineUp, awayLineUp: awayLineUp)
        viewModel.coordinator = self
        let controller = LineUpListViewController.instantiate()
        controller.viewModel = viewModel
        currentController = controller
        return controller
    }
}
