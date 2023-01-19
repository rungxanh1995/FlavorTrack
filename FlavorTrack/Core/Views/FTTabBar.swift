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

	private func configTabBarController() -> Void {
		viewControllers = [
			createSearchNavigationController(),
			createFavListNavigationController()
		]
	}
	
	private func createSearchNavigationController() -> UINavigationController {
		let searchVC = SearchVC()
		searchVC.title = "Search"
		searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
		return UINavigationController(rootViewController: searchVC)
	}
	
	private func createFavListNavigationController() -> UINavigationController {
		let favListVC = FavoriteListVC()
		favListVC.title = "Favorites"
		favListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
		return UINavigationController(rootViewController: favListVC)
	}
	
	private func configTabAndNavigationBarColors() -> Void {
		UITabBar.appearance().tintColor = UIColor.theme.accent
		UINavigationBar.appearance().tintColor = UIColor.theme.accent
	}

}
