//
//  StatisticsCellViewModel.swift
//  MyTeams
//
//  Created by Martin Bucko on 18/01/2022.
//

import Foundation

class StatisticsCellViewModel {
    private let type: String?
    private let homeValue: String?
    private let awayValue: String?

    init(type: String?, homeValue: String?, awayValue: String?) {
        self.type = type
        self.homeValue = homeValue
        self.awayValue = awayValue
    }
}

extension StatisticsCellViewModel {
    var typeString: String { type ?? "" }
    var homeValueString: String { homeValue ?? "0" }
    var awayValueString: String { awayValue ?? "0" }
    var progressBarValue: Float {
        let homeValueInt = Float(homeValueString.replacingOccurrences(of: "%", with: "")) ?? 0.0
        let awayValueInt = Float(awayValueString.replacingOccurrences(of: "%", with: "")) ?? 0.0
        if homeValueInt == 0.0 && awayValueInt == 0.0 { return 0.5 }
        else if homeValueInt == 0.0 && awayValueInt != 0.0 { return 0.0 }
        else if homeValueInt != 0.0 && awayValueInt == 0.0 { return 1.0 }
        else { return homeValueInt / (homeValueInt + awayValueInt) }
    }
}
