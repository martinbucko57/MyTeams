//
//  EventCellViewModel.swift
//  MyTeams
//
//  Created by Martin Bucko on 12/01/2022.
//

import Foundation
import UIKit

class EventCellViewModel {
    private let event: Event

    init(event: Event) {
        self.event = event
    }
}

extension EventCellViewModel {
    var time: String { "\(event.time.elapsed)'" }
    var typeImage: UIImage? { getTypeImage(event: event) }
    var players: String { getPlayersText(event: event) }
    var status: TeamStatus? { event.team.status }
    var timeHomeHidden: Bool { event.team.status == .away }
    var timeAwayHidden: Bool { event.team.status == .home }
    var typeHomeHidden: Bool { event.team.status == .away }
    var typeAwayHidden: Bool { event.team.status == .home }
    var playersAlignment: NSTextAlignment { event.team.status == .home ? .left : .right }

    private func getTypeImage(event: Event) -> UIImage? {
        switch event.type {
        case .goal:
            switch event.detail {
            case .normalGoal: return AppConstants.Images.goalGreenImage
            case .ownGoal: return AppConstants.Images.goalRedImage
            case .penalty: return AppConstants.Images.goalOrangeImage
            case .missedPenalty: return AppConstants.Images.missedPenaltyImage
            default: return AppConstants.Images.questionMarkImage
            }
        case .card:
            switch event.detail {
            case .yellowCard: return AppConstants.Images.yellowCardImage
            case .secondYellowCard: return AppConstants.Images.secondYellowCardImage
            case .redCard: return AppConstants.Images.redCardImage
            default: return AppConstants.Images.questionMarkImage
            }
        case .substitution: return AppConstants.Images.substitutionImage
        case .VAR: return AppConstants.Images.varImage
        default: return AppConstants.Images.questionMarkImage
        }
    }
    
    private func getPlayersText(event: Event) -> String {
        var textFields: [String] = []
        textFields.append(event.player1.name ?? "")
        switch event.type {
        case .goal:
            switch event.detail {
            case .normalGoal:
                if let player2 = event.player2.name {
                    textFields.append("(\(player2))")
                }
            case .ownGoal, .penalty, .missedPenalty: textFields.append("(\(event.detail.rawValue))")
            default: break
            }
        case .substitution: textFields.append("(\(event.player2.name ?? ""))")
        case .card:
            if let comment = event.comments {
                textFields.append("(\(comment))")
            }
        case .VAR: textFields.append("(\(event.detail.rawValue))")
        default: break
        }
        return event.team.status == .home ? textFields.joined(separator: " ") : textFields.reversed().joined(separator: " ")
    }
}
