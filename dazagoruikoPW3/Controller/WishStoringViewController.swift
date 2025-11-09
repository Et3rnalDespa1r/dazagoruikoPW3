//
//  WishStoringViewController.swift
//  dazagoruikoPW3
//
//  Created by Даниил on 10.11.2025.
//

import UIKit
final class WishStoringViewController: UIViewController {
    private let table: UITableView = UITableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        configureTable()
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .red
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.pin(to: view, Constants.tableOffset)
    }
}

extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 0 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { UITableViewCell() }
}

