//
//  FTTabBar.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

final class FTTabBar: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()

		configTabBarController()
		configTabAndNavigationBarColors()
	}

	private func configTabBarController() {
		viewControllers = [
			createSearchNavigationController(),
			createFavListNavigationController()
		]
	}

	private func createSearchNavigationController() -> UINavigationController {
		let searchVC = SearchVC()
		searchVC.title = NSLocalizedString("Search", comment: "The title of Search view controller")
		searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
		return UINavigationController(rootViewController: searchVC)
	}

	private func createFavListNavigationController() -> UINavigationController {
		let favListVC = FavoriteListVC()
		favListVC.title = NSLocalizedString("Favorites", comment: "The title of Favorites view controller")
		favListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
		return UINavigationController(rootViewController: favListVC)
	}

	private func configTabAndNavigationBarColors() {
		UITabBar.appearance().tintColor = UIColor.theme.accent
		UINavigationBar.appearance().tintColor = UIColor.theme.accent
	}

}
