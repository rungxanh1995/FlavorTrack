//
//  BusinessInfoMapVC.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-15.
//

import UIKit
import MapKit

class BusinessInfoMapVC: UIViewController {
	
	private var mapView: MKMapView!
	private var businessAnnotation: BusinessMapAnnotation!
	
	init(for business: Business) {
		super.init(nibName: nil, bundle: nil)
		self.businessAnnotation = .init(title: business.name,
										coordinate: .init(latitude: business.coordinates.latitude,
														  longitude: business.coordinates.longitude),
										info: business.readableCategories)
		self.mapView = .init()
	}
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		layoutUI()
		configMapRegionAndAnnotation()
	}
}

private extension BusinessInfoMapVC {
	
	private func layoutUI() -> Void {
		view.addAllSubviewsAndDisableAutoConstraints(mapView)
		mapView.isUserInteractionEnabled = true
		
		NSLayoutConstraint.activate([
			mapView.topAnchor.constraint(equalTo: view.topAnchor),
			mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private func configMapRegionAndAnnotation() -> Void {
		mapView.region = MKCoordinateRegion(center: businessAnnotation.coordinate,
											span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
		mapView.addAnnotation(businessAnnotation)
	}
}
