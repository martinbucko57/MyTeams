//
//  MatchTableViewCell.swift
//  MyTeams
//
//  Created by Martin Bucko on 01/01/2022.
//

import UIKit
import Foundation

class MatchTableViewCell : UITableViewCell {
    
    static let identifier: String = "MatchCell"
    static let height: CGFloat = 60
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var logoHomeImageView: UIImageView!
    @IBOutlet weak var logoAwayImageView: UIImageView!
    @IBOutlet weak var nameHomeLabel: UILabel!
    @IBOutlet weak var nameAwayLabel: UILabel!
    @IBOutlet weak var scoreHomeLabel: UILabel!
    @IBOutlet weak var scoreAwayLabel: UILabel!
    
    var viewModel: MatchCellViewModel?
    
    func configure(viewModel: MatchCellViewModel) {
        self.viewModel = viewModel
        setupUI()
    }
    
    private func setupUI() {
        setupData()
        setupFonts()
    }
    
    private func setupData() {
        guard let viewModel = viewModel else { return }

        dateLabel.text = viewModel.dateString
        logoHomeImageView.load(url: viewModel.logoHomeURL, placeholder: AppConstants.Images.shieldImage)
        logoAwayImageView.load(url: viewModel.logoAwayURL, placeholder: AppConstants.Images.shieldImage)
        nameHomeLabel.text = viewModel.nameHome
        nameAwayLabel.text = viewModel.nameAway
        scoreHomeLabel.text = viewModel.scoreHome
        scoreAwayLabel.text = viewModel.scoreAway
    }
    
    private func setupFonts() {
        guard let viewModel = viewModel, let scoreHome = Int(viewModel.scoreHome), let scoreAway = Int(viewModel.scoreAway) else {
            bothTeamsClear()
            return
        }

        if scoreHome > scoreAway {
            homeTeamBold()
        } else if scoreHome < scoreAway {
            awayTeamBold()
        } else {
            bothTeamsClear()
        }
    }
    
    private func homeTeamBold() {
        nameHomeLabel.font = nameHomeLabel.font.bold()
        scoreHomeLabel.font = scoreHomeLabel.font.bold()
        nameAwayLabel.font = nameAwayLabel.font.removeBold()
        scoreAwayLabel.font = scoreAwayLabel.font.removeBold()
    }
    
    private func awayTeamBold() {
        nameHomeLabel.font = nameHomeLabel.font.removeBold()
        scoreHomeLabel.font = scoreHomeLabel.font.removeBold()
        nameAwayLabel.font = nameAwayLabel.font.bold()
        scoreAwayLabel.font = scoreAwayLabel.font.bold()
    }
    
    private func bothTeamsClear() {
        nameHomeLabel.font = nameHomeLabel.font.removeBold()
        scoreHomeLabel.font = scoreHomeLabel.font.removeBold()
        nameAwayLabel.font = nameAwayLabel.font.removeBold()
        scoreAwayLabel.font = scoreAwayLabel.font.removeBold()
    }
}
