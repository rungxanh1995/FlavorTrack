//
//  BusinessMapAnnotation.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-15.
//

import Foundation
import MapKit

/// Converts domain type to MapKit compatible annotation type,
/// so that it could be used as a map annotation in a map view.
class BusinessMapAnnotation: NSObject, MKAnnotation {
	var title: String?
	var coordinate: CLLocationCoordinate2D
	var info: String

	init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
		self.title = title
		self.coordinate = coordinate
		self.info = info
	}
}

extension BusinessMapAnnotation {
	static func generate(from business: Business) -> BusinessMapAnnotation {
		return .init(
			title: business.name,
			coordinate: .init(latitude: business.coordinates.latitude, longitude: business.coordinates.longitude),
			info: business.readableCategories)
	}
}
