//
//  FavoriteListVC.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

final class FavoriteListVC: UIViewController {
	private var allFavorites: [Business] = []
	private var tableView: UITableView!

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		getFavoriteList()
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .systemBackground
		title = NSLocalizedString("Favorite Places", comment: "")

		configTableView()
    }

	private func getFavoriteList() {
		let result = PersistenceManager.retrieveFavoritesAndHandleError()
		switch result {
		case .success(let favorites):
			if favorites.isEmpty {
				showEmptyStateView(saying: "No favorite places added yet!\nGo add some 😊", in: view)
			} else {
				allFavorites = favorites
				tableView.reloadData()
				view.bringSubviewToFront(tableView)
			}
		case .failure: break
		}
	}

	private func configTableView() {
		tableView = .init(frame: view.bounds, style: .insetGrouped)
		view.addSubview(tableView)

		tableView.delegate = self
		tableView.dataSource = self
		tableView.rowHeight = 72
		tableView.register(FavoriteListCell.self, forCellReuseIdentifier: FavoriteListCell.reuseIdentifier)
	}
}

extension FavoriteListVC: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		allFavorites.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: FavoriteListCell.reuseIdentifier,
			for: indexPath) as? FavoriteListCell else {
			fatalError("FavoriteListCell does not exist")
		}
		cell.set(with: allFavorites[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)

		let selectedFavorite = allFavorites[indexPath.row]
		let targetVC: BusinessInfoVC = .init(for: selectedFavorite)
		let navController: UINavigationController = .init(rootViewController: targetVC)
		present(navController, animated: true)
	}

	func tableView(
		_ tableView: UITableView,
		commit editingStyle: UITableViewCell.EditingStyle,
		forRowAt indexPath: IndexPath) {

		guard editingStyle == .delete else { return }
		let favoriteToDelete = allFavorites[indexPath.row]

		let savingError = PersistenceManager.updateWith(favoriteToDelete, forAction: .remove)
		if let savingError {
			presentAlert(message: savingError.rawValue)
			return
		} else {
			allFavorites.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .left)

			if allFavorites.isEmpty {
				showEmptyStateView(saying: "No favorite places added yet!\nGo add some 😊", in: view)
			}
		}
	}
}
