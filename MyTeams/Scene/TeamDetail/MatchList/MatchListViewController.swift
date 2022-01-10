//
//  MatchListViewController.swift
//  MyTeams
//
//  Created by Martin Bucko on 31/12/2021.
//

import UIKit

class MatchListViewController: BaseViewController {

    @IBOutlet weak var leagueListButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
        
    var viewModel: MatchListViewModelType?
    
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

extension MatchListViewController {
    private func setupViewModel() {
        viewModel?.outputs.isFetching = { [weak self] status in
            DispatchQueue.main.async {
                self?.leagueListButton.isEnabled = !status
                status ? self?.showLoader(in: self?.tableView) : self?.hideLoader()
            }
        }
        viewModel?.outputs.didFinishFetching = { [weak self] scrollTo in
            DispatchQueue.main.async {
                self?.leagueListButton.setTitle(self?.viewModel?.selectedLeague?.name, for: .normal)
                self?.tableView.reloadData()
                if let scrollTo = scrollTo, scrollTo > 0 {
                    self?.tableView.scrollToRow(at: IndexPath(row: scrollTo, section: 0), at: .top, animated: false)
                }
            }
        }
    }
    
    private func setupUI() {
        tableView.layer.cornerRadius = 10.0
        let cellNib = UINib(nibName: String(describing: MatchTableViewCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: MatchTableViewCell.identifier)
        leagueListButton.setTitle("All leagues", for: .normal)
    }
}

extension MatchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.inputs.matchTapped(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MatchTableViewCell.height
    }
}

extension MatchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.identifier, for: indexPath) as? MatchTableViewCell else { fatalError("Cannot create user cell") }
        if let matchViewModel = viewModel?.matchViewModels[indexPath.row] {
            cell.configure(viewModel: matchViewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.matchViewModels.count ?? 0
    }
}
