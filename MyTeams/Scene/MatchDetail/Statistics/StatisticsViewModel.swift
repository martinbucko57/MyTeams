//
//  StatisticsViewModel.swift
//  MyTeams
//
//  Created by Martin Bucko on 17/01/2022.
//

import Foundation

protocol StatisticsViewModelInputs {}

protocol StatisticsViewModelOutputs {}

protocol StatisticsViewModelType {
    var inputs: StatisticsViewModelInputs { get set }
    var outputs: StatisticsViewModelOutputs { get set }
    
    var statisticsViewModels: [StatisticsCellViewModel] { get }
}

class StatisticsViewModel: StatisticsViewModelType, StatisticsViewModelOutputs, StatisticsViewModelInputs {
    
    var inputs: StatisticsViewModelInputs { get { return self } set{} }
    var outputs: StatisticsViewModelOutputs { get { return self } set{} }

    var coordinator: StatisticsCoordinatorType?
    
    var statisticsViewModels: [StatisticsCellViewModel]
    
    private let homeStatistics: FixtureTeamStatistics
    private let awayStatistics: FixtureTeamStatistics

    init(homeStatistics: FixtureTeamStatistics, awayStatistics: FixtureTeamStatistics) {
        self.homeStatistics = homeStatistics
        self.awayStatistics = awayStatistics
        self.statisticsViewModels = StatisticsViewModel.parseStatistics(homeStatistics: homeStatistics.statistics, awayStatistics: awayStatistics.statistics)
    }
}

extension StatisticsViewModel {
    private static func parseStatistics(homeStatistics: [FixtureStatistic], awayStatistics: [FixtureStatistic]) -> [StatisticsCellViewModel] {
        var cellViewModels = [StatisticsCellViewModel]()
        for index in 0..<max(homeStatistics.count, awayStatistics.count) {
            cellViewModels.append(StatisticsCellViewModel(type: homeStatistics[safe: index]?.type, homeValue: homeStatistics[safe: index]?.value, awayValue: awayStatistics[safe: index]?.value))
        }
        return cellViewModels
    }
}

