//
//  TeamDetailViewController.swift
//  MyTeams
//
//  Created by Martin Bucko on 29/12/2021.
//

import UIKit

class TeamDetailViewController: BaseViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    var viewModel: TeamDetailViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupUI()
        viewModel?.inputs.viewDidLoad()
    }
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        viewModel?.inputs.segmentValueChanged(selectedIndex: segmentedControl.selectedSegmentIndex)
    }
    
    @objc func favouriteTapped() {
        viewModel?.inputs.favouriteTapped()
     }
}

extension TeamDetailViewController {
    private func setupViewModel() {
        viewModel?.outputs.didUpdateFavor = { [weak self] in
            DispatchQueue.main.async {
                guard let viewModel = self?.viewModel else { return }
                self?.favouriteImageView.image = viewModel.isFavourite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            }
        }
    }
    
    private func setupUI() {
        guard let viewModel = viewModel else { return }
        self.navigationItem.title = viewModel.teamName
        logoImageView.load(url: viewModel.teamLogo, placeholder: UIImage(systemName: "xmark.shield"))
        teamNameLabel.text = viewModel.teamName.uppercased()
        favouriteImageView.image = viewModel.isFavourite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        
        let favouriteTap = UITapGestureRecognizer(target: self, action: #selector(favouriteTapped))
        favouriteImageView.isUserInteractionEnabled = true
        favouriteImageView.addGestureRecognizer(favouriteTap)
    }
}


