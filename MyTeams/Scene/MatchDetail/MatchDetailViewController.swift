//
//  MatchDetailViewController.swift
//  MyTeams
//
//  Created by Martin Bucko on 08/01/2022.
//

import UIKit

class MatchDetailViewController: BaseViewController {

    @IBOutlet weak var teamHomeLogo: UIImageView!
    @IBOutlet weak var teamAwayLogo: UIImageView!
    @IBOutlet weak var teamHomeNameLabel: UILabel!
    @IBOutlet weak var teamAwayNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timeElapsedLabel: UILabel!
    
    var viewModel: MatchDetailViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()
        setupUI()
        viewModel?.inputs.viewDidLoad()
    }
}

extension MatchDetailViewController {
    private func setupViewModel() {
        viewModel?.outputs.isFetching = { [weak self] status in
            DispatchQueue.main.async {
                status ? self?.showLoader(blurred: true) : self?.hideLoader()
            }
        }
        viewModel?.outputs.didFinishFetching = { [weak self] in
            DispatchQueue.main.async {
                self?.setupUI()
            }
        }
    }
    
    private func setupUI() {
        guard let viewModel = viewModel else { return }

        teamHomeLogo.load(url: viewModel.teamHomeURL, placeholder: UIImage(systemName: "xmark.shield"))
        teamAwayLogo.load(url: viewModel.teamAwayURL, placeholder: UIImage(systemName: "xmark.shield"))
        teamHomeNameLabel.text = viewModel.teamHomeName
        teamAwayNameLabel.text = viewModel.teamAwayName
        dateLabel.text = viewModel.matchDate
        scoreLabel.text = viewModel.matchScore
        switch viewModel.timeElapsed {
        case "90'", "120'":
            statusLabel.isHidden = false
            statusLabel.text = viewModel.matchStatus
        default:
            statusLabel.isHidden = true
        }
        if ((viewModel.matchStatus?.contains("Match Finished")) != nil) {
            timeElapsedLabel.isHidden = true
        } else {
            timeElapsedLabel.isHidden = false
            timeElapsedLabel.text = viewModel.timeElapsed
        }
    }
}
