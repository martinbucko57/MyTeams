//
//  EventTableViewCell.swift
//  MyTeams
//
//  Created by Martin Bucko on 12/01/2022.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    static let identifier: String = "EventCell"
    static let height: CGFloat = 30
    
    @IBOutlet weak var timeHomeLabel: UILabel!
    @IBOutlet weak var timeAwayLabel: UILabel!
    @IBOutlet weak var typeHomeImageView: UIImageView!
    @IBOutlet weak var typeAwayImageView: UIImageView!
    @IBOutlet weak var playersLabel: UILabel!
    
    var viewModel: EventCellViewModel?
    
    func configure(viewModel: EventCellViewModel) {
        self.viewModel = viewModel
        setupUI()
    }
    
    private func setupUI() {
        guard let viewModel = viewModel else { return }

        timeHomeLabel.isHidden = viewModel.timeHomeHidden
        timeAwayLabel.isHidden = viewModel.timeAwayHidden
        typeHomeImageView.isHidden = viewModel.typeHomeHidden
        typeAwayImageView.isHidden = viewModel.typeAwayHidden
        playersLabel.textAlignment = viewModel.playersAlignment
        
        if viewModel.status == .home {
            timeHomeLabel.text = viewModel.time
            typeHomeImageView.image = viewModel.typeImage
        } else if viewModel.status == .away {
            timeAwayLabel.text = viewModel.time
            typeAwayImageView.image = viewModel.typeImage
        }
        playersLabel.text = viewModel.players
    }
}
