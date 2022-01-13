//
//  EventListViewModel.swift
//  MyTeams
//
//  Created by Martin Bucko on 10/01/2022.
//

import Foundation

protocol EventListViewModelInputs {}

protocol EventListViewModelOutputs {}

protocol EventListViewModelType {
    var inputs: EventListViewModelInputs { get set }
    var outputs: EventListViewModelOutputs { get set }
    
    var eventViewModels: [EventCellViewModel] { get }
}

class EventListViewModel: EventListViewModelType, EventListViewModelOutputs, EventListViewModelInputs {
    
    var inputs: EventListViewModelInputs { get { return self } set{} }
    var outputs: EventListViewModelOutputs { get { return self } set{} }

    var coordinator: EventListCoordinatorType?
    
    var didFinishFetching: ((Int?) -> Void)?
    var isFetching: ((Bool) -> Void)?
    
    var eventViewModels: [EventCellViewModel]

    private let eventList: [Event]

    init(eventList: [Event]) {
        self.eventList = eventList
        self.eventViewModels = eventList.map { EventCellViewModel(event: $0) }
    }
}
