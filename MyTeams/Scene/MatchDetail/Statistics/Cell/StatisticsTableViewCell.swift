//
//  StatisticsTableViewCell.swift
//  MyTeams
//
//  Created by Martin Bucko on 18/01/2022.
//

import UIKit

class StatisticsTableViewCell: UITableViewCell {

    static let identifier: String = "StatisticsCell"
    static let height: CGFloat = 40
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var homeValueLabel: UILabel!
    @IBOutlet weak var awayValueLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var viewModel: StatisticsCellViewModel?
    
    func configure(viewModel: StatisticsCellViewModel) {
        self.viewModel = viewModel
        setupUI()
    }
    
    private func setupUI() {
        guard let viewModel = viewModel else { return }

        typeLabel.text = viewModel.typeString
        homeValueLabel.text = viewModel.homeValueString
        awayValueLabel.text = viewModel.awayValueString
        progressBar.progress = viewModel.progressBarValue
    }
}
