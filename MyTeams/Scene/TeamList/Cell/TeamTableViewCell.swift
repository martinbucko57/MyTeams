//
//  TeamTableViewCell.swift
//  MyTeams
//
//  Created by Martin Bucko on 17/12/2021.
//

import UIKit
import Foundation

class TeamTableViewCell : UITableViewCell {
    
    static let identifier: String = "TeamCell"
    static let height: CGFloat = 80

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favouriteImageView: UIImageView!
    
    func configure(viewModel: TeamCellViewModel, scene: TeamCellScene) {
        nameLabel.text = viewModel.teamName
        logoImageView.load(url: viewModel.teamLogo, placeholder: UIImage(systemName: "xmark.shield"))
        favouriteImageView.isHidden = scene == .teamList ? true : !viewModel.isFavourite
    }
    
    enum TeamCellScene {
        case teamList, searchTeam
    }
}
