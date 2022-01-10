//
//  StandingsTableViewCell.swift
//  MyTeams
//
//  Created by Martin Bucko on 07/01/2022.
//

import UIKit
import Foundation

class StandingsTableViewCell: UITableViewCell {
    
    static let identifier: String = "StandingsCell"
    static let height: CGFloat = 40
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var playedMatchesLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    var viewModel: StandingsCellViewModel?

    func configure(viewModel: StandingsCellViewModel) {
        self.viewModel = viewModel
        setupUI()
    }
    
    private func setupUI() {
        guard let viewModel = viewModel else { return }
        
        rankLabel.text = viewModel.rank
        teamLogoImageView.load(url: viewModel.teamLogoURL, placeholder: UIImage(systemName: "xmark.shield"))
        teamNameLabel.text = viewModel.teamName
        playedMatchesLabel.text = viewModel.playedMatches
        scoreLabel.text = viewModel.score
        pointsLabel.text = viewModel.points
    }
}
