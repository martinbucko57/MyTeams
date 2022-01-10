// 
//  TeamListViewController.swift
//  MyTeams
//
//  Created by Martin Bucko on 17/12/2021.
//

import UIKit

class TeamListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
        
    var viewModel: TeamListViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        setupViewModel()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.inputs.viewDidAppear()
    }
}

extension TeamListViewController {
    private func setupViewModel() {
        viewModel?.outputs.didFinishFetching = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func setupUI() {
        self.navigationItem.title = "Favourites"
        let cellNib = UINib(nibName: String(describing: TeamTableViewCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TeamTableViewCell.identifier)
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        self.navigationItem.rightBarButtonItem = addItem
    }
    
    @objc func addButtonTapped() {
        viewModel?.inputs.addTapped()
    }
}

extension TeamListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.inputs.teamTapped(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TeamTableViewCell.height
    }
}

extension TeamListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.identifier, for: indexPath) as? TeamTableViewCell else { fatalError("Cannot create user cell") }
        if let teamViewModel = viewModel?.teamViewModels[indexPath.row] {
            cell.configure(viewModel: teamViewModel, scene: .teamList)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.teamViewModels.count ?? 0
    }
}
