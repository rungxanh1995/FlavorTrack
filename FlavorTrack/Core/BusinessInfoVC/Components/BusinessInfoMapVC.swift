//
//  BusinessInfoMapVC.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-15.
//

import UIKit
import MapKit

internal protocol MapNavigationRequestDelegate: AnyObject {
	func didRequestMapNavigation(to business: Business)
}

final class BusinessInfoMapVC: UIViewController {

	private var mapView: MKMapView!
	private var callToActionButton: FTButton!

	private var business: Business!
	weak var delegate: MapNavigationRequestDelegate!

	init(for business: Business, delegate: MapNavigationRequestDelegate) {
		super.init(nibName: nil, bundle: nil)
		self.business = business
		self.mapView = .init()
		self.callToActionButton = .init(withTitle: "Take me there!")
		self.delegate = delegate
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override func viewDidLoad() {
		super.viewDidLoad()

		layoutUI()
		configMapView()
		configMapRegionAndAnnotation()
		configActionButton()
	}
}

private extension BusinessInfoMapVC {

	private func layoutUI() {
		view.addAllSubviewsAndDisableAutoConstraints(mapView, callToActionButton)
		mapView.constrainToUpperHalf(of: view)
		callToActionButton.constrainToLowerHalf(of: view)

		// extra constraints
		NSLayoutConstraint.activate([
			mapView.heightAnchor.constraint(equalToConstant: 280),
			callToActionButton.heightAnchor.constraint(equalToConstant: 44)
		])
	}

	private func configMapView() {
		mapView.isUserInteractionEnabled = true
		mapView.layer.cornerRadius = 8.0
		mapView.layer.borderWidth = 1
		mapView.layer.borderColor = UIColor.systemGray4.cgColor
		mapView.layer.masksToBounds = false
		mapView.clipsToBounds = true
	}

	private func configMapRegionAndAnnotation() {
		let annotation = BusinessMapAnnotation.generate(from: business)
		let zoomLevel = 0.005
		mapView.region = MKCoordinateRegion(center: annotation.coordinate,
											span: MKCoordinateSpan(latitudeDelta: zoomLevel, longitudeDelta: zoomLevel))
		mapView.addAnnotation(annotation)
	}

	private func configActionButton() {
		callToActionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
	}

	@objc private func didTapActionButton() {
		delegate.didRequestMapNavigation(to: business)
	}
}
