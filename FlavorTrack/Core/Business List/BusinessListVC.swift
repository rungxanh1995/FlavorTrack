//
//  BusinessListVC.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

final class BusinessListVC: UIViewController, LoadableScreen {
	
	internal enum CollectionSection { case main }
	
    private var businessType: String!
    private var searchedLocation: String!
	private var businessList: [Business] = []
	private var filteredBusinessList: [Business] = []
	
	private var isInSearchMode: Bool = false
	
	internal var containerView: UIView!
	private var collectionView: UICollectionView!
	private var dataSource: UICollectionViewDiffableDataSource<CollectionSection, Business>!
	
	init(for businessType: String, near location: String) {
		super.init(nibName: nil, bundle: nil)
		self.businessType = businessType
		self.searchedLocation = location
	}
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		title = businessType.capitalized.localizedDynamicString(near: searchedLocation.capitalized)
		
		configCollectionView()
		configDataSource()
		configSearchBar()
		getBusinessList(for: businessType, near: searchedLocation)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
}

// MARK: - UI/Data Configuration
private extension BusinessListVC {
	private func configCollectionView() {
		collectionView = .init(frame: view.bounds, collectionViewLayout: UIHelper.makeThreeColumnFlowLayout(in: view))
		view.addSubview(collectionView)
		collectionView.backgroundColor = .systemBackground
		collectionView.register(BusinessCell.self, forCellWithReuseIdentifier: BusinessCell.reuseIdentifier)
		
		collectionView.delegate = self // for pagination
	}
	
	private func configDataSource() {
		dataSource = .init(collectionView: collectionView,
						   cellProvider: { (collectionView, indexPath, business) -> UICollectionViewCell? in
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BusinessCell.reuseIdentifier, for: indexPath) as! BusinessCell
			cell.set(with: business)
			return cell
		})
	}
	
	private func configSearchBar() {
		let searchController: UISearchController = .init()
		searchController.searchBar.placeholder = NSLocalizedString("Search a name", comment: "The placeholder of search bar in Business list controller")
		searchController.searchResultsUpdater = self
		navigationItem.hidesSearchBarWhenScrolling = false
		navigationItem.searchController = searchController
	}
	
	private func getBusinessList(for businessType: String, near location: String) {
		showLoadingOverlay()
		
		defer { dismissLoadingOverlay() }
		
		Task {
			do {
				let result: RawServerResponse = try await BusinessDataService.shared.fetchData(nearby: location, businessType: businessType)
				updateUI(with: result.businesses.sorted { $0.distance < $1.distance })
			} catch let error as BusinessDataService.NetworkError {
				presentAlert(message: error.rawValue)
			} catch { presentDefaultAlert() }
		}
	}
	
	private func updateUI(with newBusinessList: [Business]) {
		businessList.append(contentsOf: newBusinessList)
		
		if businessList.isEmpty {
			DispatchQueue.main.async { [weak self] in
				guard let self else { return }
				self.showEmptyStateView(saying: "No results matching what you're looking for 😢", in: self.view)
				return
			}
		} else {
			updateData(using: businessList)
		}
	}
	
	private func updateData(using businessList: [Business]) {
		var snapshot: NSDiffableDataSourceSnapshot<CollectionSection, Business> = .init()
		snapshot.appendSections([.main])
		snapshot.appendItems(businessList)
		DispatchQueue.main.async { [weak self] in
			self?.dataSource.apply(snapshot, animatingDifferences: true)
		}
	}
}

extension BusinessListVC: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let selectedItem = isInSearchMode ? filteredBusinessList[indexPath.item] : businessList[indexPath.item]
		let targetVC: BusinessInfoVC = .init(for: selectedItem, near: searchedLocation)
		let navController: UINavigationController = .init(rootViewController: targetVC)
		present(navController, animated: true)
	}
}

extension BusinessListVC: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
			isInSearchMode = false
			filteredBusinessList.removeAll()
			updateData(using: businessList)
			return
		}
		
		isInSearchMode = true
		filteredBusinessList = businessList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
		updateData(using: filteredBusinessList)
	}
}
