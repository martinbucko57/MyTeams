//
//  SearchTeamViewController.swift
//  MyTeams
//
//  Created by Martin Bucko on 26/12/2021.
//

import UIKit

class SearchTeamViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
        
    var viewModel: SearchTeamViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        setupViewModel()
        setupUI()
        viewModel?.inputs.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.inputs.viewWillDisappear()
    }
}

extension SearchTeamViewController {
    private func setupViewModel() {
        viewModel?.outputs.didFinishFetching = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel?.outputs.didRowChange = { [weak self] indexPath in
            DispatchQueue.main.async {
                self?.tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }

    private func setupUI() {
        self.navigationItem.title = "Search"
        let cellNib = UINib(nibName: String(describing: TeamTableViewCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TeamTableViewCell.identifier)
    }
}

extension SearchTeamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.inputs.teamTapped(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TeamTableViewCell.height
    }
}

extension SearchTeamViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.identifier, for: indexPath) as? TeamTableViewCell else { fatalError("Cannot create user cell") }
        if let teamViewModel = viewModel?.searchTeamViewModels[indexPath.row] {
            cell.configure(viewModel: teamViewModel, scene: .searchTeam)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.searchTeamViewModels.count ?? 0
    }
}

extension SearchTeamViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchBar.resignFirstResponder()
        viewModel?.inputs.searchTriggered(with: text)
    }
}
