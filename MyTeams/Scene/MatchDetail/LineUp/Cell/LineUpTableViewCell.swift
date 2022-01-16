//
//  LineUpTableViewCell.swift
//  MyTeams
//
//  Created by Martin Bucko on 14/01/2022.
//

import UIKit

class LineUpTableViewCell: UITableViewCell {

    static let identifier: String = "LineUpCell"
    static let height: CGFloat = 30
    
    @IBOutlet weak var homePlayerNumberLabel: UILabel!
    @IBOutlet weak var awayPlayerNumberLabel: UILabel!
    @IBOutlet weak var homePlayerNameLabel: UILabel!
    @IBOutlet weak var awayPlayerNameLabel: UILabel!
    
    var viewModel: LineUpCellViewModel?
    
    func configure(viewModel: LineUpCellViewModel) {
        self.viewModel = viewModel
        setupUI()
    }
    
    private func setupUI() {
        guard let viewModel = viewModel else { return }
        
        homePlayerNumberLabel.text = viewModel.homePlayerNumber
        homePlayerNameLabel.text = viewModel.homePlayerName
        awayPlayerNumberLabel.text = viewModel.awayPlayerNumber
        awayPlayerNameLabel.text = viewModel.awayPlayerName
    }
}
