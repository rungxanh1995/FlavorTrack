//
//  Business.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import Foundation

struct Business: Codable {
	let id: String
	let name: String
	let imageURL: String
	let isClosed: Bool
	let yelpUrl: String
	let categories: [Category]
	let rating: Double
	let coordinates: Coordinates
	var price: String?
	var location: Location?
	var phone, displayPhone: String?
	let distance: Double

	internal enum CodingKeys: String, CodingKey {
		case id = "id"
		case name = "name"
		case imageURL = "image_url"
		case isClosed = "is_closed"
		case yelpUrl = "url"
		case categories, rating, coordinates, price, location, phone
		case displayPhone = "display_phone"
		case distance = "distance"
	}
}

extension Business: Hashable {
	static func == (lhs: Business, rhs: Business) -> Bool { lhs.id == rhs.id }
}

// MARK: - Category
struct Category: Codable, Hashable {
	var title: String?
}

// MARK: - Center
struct Coordinates: Codable, Hashable {
	var latitude, longitude: Double
}

// MARK: - Location
struct Location: Codable, Hashable {
	var address1, address2: String?
	var city, zipCode, state: String?
	var displayAddress: [String]?

	enum CodingKeys: String, CodingKey {
		case address1, address2
		case city = "city"
		case zipCode = "zip_code"
		case state = "state"
		case displayAddress = "display_address"
	}
}
