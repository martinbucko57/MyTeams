//
//  EventListCoordinator.swift
//  MyTeams
//
//  Created by Martin Bucko on 10/01/2022.
//

import UIKit

protocol EventListCoordinatorType {
    func start() -> UIViewController
}

class EventListCoordinator: EventListCoordinatorType {
    
    private var parentCoordinator: MatchDetailCoordinatorType
    private weak var currentController: EventListViewController?
    
    let eventList: [Event]
    
    init(parentCoordinator: MatchDetailCoordinatorType, eventList: [Event]) {
        self.parentCoordinator = parentCoordinator
        self.eventList = eventList
    }
    
    func start() -> UIViewController {
        let viewModel = EventListViewModel(eventList: eventList)
        viewModel.coordinator = self
        let controller = EventListViewController.instantiate()
        controller.viewModel = viewModel
        currentController = controller
        return controller
    }
}
