//
//  StatisticsCoordinator.swift
//  MyTeams
//
//  Created by Martin Bucko on 17/01/2022.
//

import UIKit

protocol StatisticsCoordinatorType {
    func start() -> UIViewController
}

class StatisticsCoordinator: StatisticsCoordinatorType {
    
    private var parentCoordinator: MatchDetailCoordinatorType
    private weak var currentController: StatisticsViewController?
    
    private let homeStatistics: FixtureTeamStatistics
    private let awayStatistics: FixtureTeamStatistics
    
    init(parentCoordinator: MatchDetailCoordinatorType, homeStatistics: FixtureTeamStatistics, awayStatistics: FixtureTeamStatistics) {
        self.parentCoordinator = parentCoordinator
        self.homeStatistics = homeStatistics
        self.awayStatistics = awayStatistics
    }
    
    func start() -> UIViewController {
        let viewModel = StatisticsViewModel(homeStatistics: homeStatistics, awayStatistics: awayStatistics)
        viewModel.coordinator = self
        let controller = StatisticsViewController.instantiate()
        controller.viewModel = viewModel
        currentController = controller
        return controller
    }
}
