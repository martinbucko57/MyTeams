//
//  LineUpListViewController.swift
//  MyTeams
//
//  Created by Martin Bucko on 14/01/2022.
//

import UIKit

class LineUpListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: LineUpListViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        setupUI()
    }
}

extension LineUpListViewController {
    private func setupUI() {
        tableView.layer.cornerRadius = 10.0
        let headerNib = UINib(nibName: String(describing: LineUpTableViewHeaderCell.self), bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: LineUpTableViewHeaderCell.identifier)
        let cellNib = UINib(nibName: String(describing: LineUpTableViewCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: LineUpTableViewCell.identifier)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
}

extension LineUpListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LineUpTableViewCell.height
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return LineUpTableViewHeaderCell.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: LineUpTableViewHeaderCell.identifier) as? LineUpTableViewHeaderCell else { fatalError("Cannot create user cell") }
        header.headerLabel.text = viewModel?.lineUpViewModels[section].key
        return header
    }
}

extension LineUpListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LineUpTableViewCell.identifier, for: indexPath) as? LineUpTableViewCell else { fatalError("Cannot create user cell") }
        if let lineUpViewModel = viewModel?.lineUpViewModels[indexPath.section].value[indexPath.row] {
            cell.configure(viewModel: lineUpViewModel)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.lineUpViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.lineUpViewModels[section].value.count ?? 0
    }
}
