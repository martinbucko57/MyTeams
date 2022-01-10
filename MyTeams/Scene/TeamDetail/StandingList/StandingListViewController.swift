//
//  StandingListViewController.swift
//  MyTeams
//
//  Created by Martin Bucko on 31/12/2021.
//

import UIKit

class StandingListViewController: BaseViewController {

    @IBOutlet weak var leagueListButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: StandingListViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        setupViewModel()
        setupUI()
        viewModel?.inputs.viewDidLoad()
    }
    
    @IBAction func leagueListButtonTapped(_ sender: Any) {
        viewModel?.inputs.leagueListButtonTapped()
    }
}

extension StandingListViewController {
    private func setupViewModel() {
        viewModel?.outputs.didFinishFetching = { [weak self] in
            DispatchQueue.main.async {
                self?.leagueListButton.setTitle(self?.viewModel?.selectedLeague?.name, for: .normal)
                self?.tableView.reloadData()
            }
        }
        viewModel?.outputs.isFetching = { [weak self] status in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.leagueListButton.isEnabled = !status && self.viewModel?.selectedLeague != nil
                status ? self.showLoader(in: self.tableView) : self.hideLoader()
            }
        }
    }
    
    private func setupUI() {
        tableView.layer.cornerRadius = 10.0
        let headerNib = UINib(nibName: String(describing: StandingsTableViewHeaderCell.self), bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: StandingsTableViewHeaderCell.identifier)
        let cellNib = UINib(nibName: String(describing: StandingsTableViewCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: StandingsTableViewCell.identifier)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
}

extension StandingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return StandingsTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: StandingsTableViewHeaderCell.identifier) as? StandingsTableViewHeaderCell else { fatalError("Cannot create user cell") }
        header.groupLabel.text = viewModel?.standingsViewModels.first?.group
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return StandingsTableViewHeaderCell.height
    }
}

extension StandingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StandingsTableViewCell.identifier, for: indexPath) as? StandingsTableViewCell else { fatalError("Cannot create user cell") }
        if let standingsViewModel = viewModel?.standingsViewModels[indexPath.row] {
            cell.configure(viewModel: standingsViewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.standingsViewModels.count ?? 0
    }
}
