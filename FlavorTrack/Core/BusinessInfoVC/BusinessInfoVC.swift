//
//  BusinessInfoVC.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-15.
//

import UIKit
import MapKit

final class BusinessInfoVC: UIViewController, LoadableScreen {

	internal var containerView: UIView!
	private var business: Business!
	private var searchedLocation: String!

	private var scrollView: UIScrollView!
	private var contentView: UIView!

	private var headerView: UIView!
	private var detailView: UIView!
	private var mapHostingView: UIView!

	init(for business: Business, near location: String = NSLocalizedString("searched location", comment: "")) {
		super.init(nibName: nil, bundle: nil)
		self.business = business
		self.searchedLocation = location
		self.scrollView = .init()
		self.contentView = .init()
		self.headerView = .init()
		self.detailView = .init()
		self.mapHostingView = .init()
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .systemBackground
		title = business.name

		configNavigationBarButtons()
		layoutUIElements()
		configUIElements(for: business)
    }
}

private extension BusinessInfoVC {

	private func configNavigationBarButtons() {
		let doneBarBtn: UIBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
		doneBarBtn.isAccessibilityElement = true
		doneBarBtn.accessibilityLabel = NSLocalizedString(
			"Done and dismiss view",
			comment: "The accessibility label of the Done navigation bar button")
		navigationItem.setRightBarButtonItems([doneBarBtn], animated: true)

		let favBarBtn: UIBarButtonItem = .init(image: SFSymbols.star, style: .plain,
											   target: self, action: #selector(favoriteButtonClicked))
		favBarBtn.isAccessibilityElement = true
		favBarBtn.accessibilityLabel = NSLocalizedString(
			"Add to favorites",
			comment: "The accessibility label of the Favorite navigation bar button")
		navigationItem.setLeftBarButtonItems([favBarBtn], animated: true)
	}

	private func layoutUIElements() {
		view.addAllSubviewsAndDisableAutoConstraints(scrollView)
		scrollView.addAllSubviewsAndDisableAutoConstraints(contentView)
		contentView.addAllSubviewsAndDisableAutoConstraints(headerView, detailView, mapHostingView)

		let edgePadding: CGFloat = 12.0
		let itemPadding: CGFloat = 24.0

		scrollView.pinToEdges(of: view)
		contentView.pinToEdges(of: scrollView)
		headerView.constrainToUpperHalf(of: contentView, padding: edgePadding)
		detailView.constrainToLeadingAndTrailingAnchors(of: contentView, padding: edgePadding)
		mapHostingView.constrainToLowerHalf(of: contentView, padding: edgePadding)

		// extra constraints
		NSLayoutConstraint.activate([
			contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
			contentView.heightAnchor.constraint(equalToConstant: 660),

			headerView.heightAnchor.constraint(equalToConstant: 120),

			detailView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: itemPadding),
			detailView.heightAnchor.constraint(equalToConstant: 120),

			mapHostingView.heightAnchor.constraint(equalToConstant: 340)
		])
	}

	private func configUIElements(for business: Business) {
		addChildController(BusinessInfoHeaderVC(
			for: business, near: searchedLocation.capitalized(with: .current)),
			to: headerView)
		addChildController(BusinessInfoDetailVC(for: business), to: detailView)
		addChildController(BusinessInfoMapVC(for: business, delegate: self), to: mapHostingView)
	}

	@objc private func dismissVC() { dismiss(animated: true) }

	@objc private func favoriteButtonClicked() {
		showLoadingOverlay()
		defer { dismissLoadingOverlay() }

		let savingError = PersistenceManager.updateWith(business, forAction: .add)
		switch savingError {
		case .none:
			presentAlert(title: "Favorited!",
						 message: business.name.localizedDynamicString(fromKey: "Successfully saved %@ to favorites"))
		case .some(let error):
			presentAlert(title: "Uh-oh!", message: error.rawValue)
		}
	}
}

extension BusinessInfoVC: MapNavigationRequestDelegate {
	/// Showcasing knowledge about using Delegate pattern to communicate between view controllers.
	///
	/// If I were to improve this further, I'd like to not go with delegation and move
	/// this method (and call to action button) to my map VC for separation of concerns.
	func didRequestMapNavigation(to business: Business) {
		let annotation = BusinessMapAnnotation.generate(from: business)
		let placemark = MKPlacemark(coordinate: annotation.coordinate)
		let mapItem = MKMapItem(placemark: placemark)
		mapItem.name = annotation.title
		mapItem.openInMaps()
	}
}
