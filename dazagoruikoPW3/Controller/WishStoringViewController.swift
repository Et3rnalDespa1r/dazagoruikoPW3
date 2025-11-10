//
//  WishStoringViewController.swift
//  dazagoruikoPW3
//
//  Created by Даниил on 10.11.2025.
//

import UIKit

final class WishStoringViewController: UIViewController {

    private let defaults = UserDefaults.standard
    private var wishArray: [String] = []
    private let table = UITableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        configureTable()
        loadWishes()
    }

    private func configureTable() {
        view.addSubview(table)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.backgroundColor = .red
        table.layer.cornerRadius = 12
        table.clipsToBounds = true
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        table.keyboardDismissMode = .onDrag
    }

    private func loadWishes() {
        if let saved = defaults.array(forKey: Constants.wishesKey) as? [String] {
            wishArray = saved
        }
        table.reloadData()
    }

    private func persist() {
        defaults.set(wishArray, forKey: Constants.wishesKey)
    }

    private func editWish(at indexPath: IndexPath) {
        let old = wishArray[indexPath.row]
        let alert = UIAlertController(title: "Edit wish", message: nil, preferredStyle: .alert)
        alert.addTextField { $0.text = old }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            guard
                let self,
                let t = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                !t.isEmpty
            else { return }
            self.wishArray[indexPath.row] = t
            self.persist()
            self.table.reloadRows(at: [indexPath], with: .automatic)
        }))
        present(alert, animated: true)
    }
}

extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 2 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : wishArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath) as! AddWishCell
            cell.addWish = { [weak self] text in
                guard let self else { return }
                self.wishArray.append(text)
                self.persist()
                self.table.reloadData()
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath) as! WrittenWishCell
            cell.configure(with: wishArray[indexPath.row])
            return cell
        }
    }
}

extension WishStoringViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section == 1 else { return }
        editWish(at: indexPath)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        indexPath.section == 1
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        guard indexPath.section == 1 else { return nil }
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _,_,done in
            guard let self else { return }
            self.wishArray.remove(at: indexPath.row)
            self.persist()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            done(true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }

    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        guard indexPath.section == 1 else { return nil }
        let edit = UIContextualAction(style: .normal, title: "Edit") { [weak self] _,_,done in
            self?.editWish(at: indexPath)
            done(true)
        }
        edit.backgroundColor = .systemBlue
        let cfg = UISwipeActionsConfiguration(actions: [edit])
        cfg.performsFirstActionWithFullSwipe = false
        return cfg
    }
}


