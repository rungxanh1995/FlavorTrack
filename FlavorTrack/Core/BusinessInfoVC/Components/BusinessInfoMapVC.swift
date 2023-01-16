//
//  BusinessInfoMapVC.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-15.
//

import UIKit
import MapKit

internal protocol MapNavigationRequestDelegate: AnyObject {
	func didRequestMapNavigation(to business: Business) -> Void
}

class BusinessInfoMapVC: UIViewController {
	
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
	
	private func layoutUI() -> Void {
		view.addAllSubviewsAndDisableAutoConstraints(mapView, callToActionButton)
		
		NSLayoutConstraint.activate([
			mapView.topAnchor.constraint(equalTo: view.topAnchor),
			mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			mapView.heightAnchor.constraint(equalToConstant: 280),
			
			callToActionButton.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 12),
			callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			callToActionButton.heightAnchor.constraint(equalToConstant: 44)
		])
	}
	
	private func configMapView() -> Void {
		mapView.isUserInteractionEnabled = true
		mapView.layer.cornerRadius = 8.0
		mapView.layer.borderWidth = 1
		mapView.layer.borderColor = UIColor.systemGray4.cgColor
		mapView.layer.masksToBounds = false
		mapView.clipsToBounds = true
	}
	
	private func configMapRegionAndAnnotation() -> Void {
		let annotation = BusinessMapAnnotation.generate(from: business)
		let zoomLevel = 0.005
		mapView.region = MKCoordinateRegion(center: annotation.coordinate,
											span: MKCoordinateSpan(latitudeDelta: zoomLevel, longitudeDelta: zoomLevel))
		mapView.addAnnotation(annotation)
	}
	
	private func configActionButton() -> Void {
		callToActionButton.addTarget(self, action: #selector(_didTapActionButton), for: .touchUpInside)
	}
	
	@objc
	private func _didTapActionButton() -> Void {
		delegate.didRequestMapNavigation(to: business)
	}
}
