//
//  WishStoringViewController.swift
//  dazagoruikoPW3
//
//  Created by Даниил on 10.11.2025.
//

import UIKit
final class WishStoringViewController: UIViewController {
    
    private var wishArray: [String] = ["I wish to add cells to the table"]
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
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.pin(to: view, Constants.tableOffset)
    }
}

extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WrittenWishCell.reuseId,
            for: indexPath
        )
        guard let wishCell = cell as? WrittenWishCell else { return cell }
        wishCell.configure(with: wishArray[indexPath.row])
        return wishCell
    }

}

