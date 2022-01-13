//
//  EventListViewController.swift
//  MyTeams
//
//  Created by Martin Bucko on 10/01/2022.
//

import UIKit

class EventListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: EventListViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        setupUI()
    }
}

extension EventListViewController {
    private func setupUI() {
        tableView.layer.cornerRadius = 10.0
        let cellNib = UINib(nibName: String(describing: EventTableViewCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: EventTableViewCell.identifier)
    }
}

extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EventTableViewCell.height
    }
}

extension EventListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as? EventTableViewCell else { fatalError("Cannot create user cell") }
        if let matchViewModel = viewModel?.eventViewModels[indexPath.row] {
            cell.configure(viewModel: matchViewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.eventViewModels.count ?? 0
    }
}
