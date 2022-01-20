//
//  StatisticsViewController.swift
//  MyTeams
//
//  Created by Martin Bucko on 17/01/2022.
//

import UIKit

class StatisticsViewController: BaseViewController {
        
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: StatisticsViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        setupUI()
    }
}

extension StatisticsViewController {
    private func setupUI() {
        tableView.layer.cornerRadius = 10.0
        let cellNib = UINib(nibName: String(describing: StatisticsTableViewCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: StatisticsTableViewCell.identifier)
    }
}

extension StatisticsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return StatisticsTableViewCell.height
    }
}


extension StatisticsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsTableViewCell.identifier, for: indexPath) as? StatisticsTableViewCell else { fatalError("Cannot create user cell") }
        if let statisticsViewModel = viewModel?.statisticsViewModels[indexPath.row] {
            cell.configure(viewModel: statisticsViewModel)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.statisticsViewModels.count ?? 0
    }
}
