//
//  ApiConstants.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import Foundation

enum ApiConstants {
	
	static private let clientId = "UrRaT15yXM8CpQDa4GBMPA"
	static private let authPrefix = "Bearer"
	static private let apiKey = "U2hid40RjXxGT6uVadesqiPJY_4hsSE5DIUEEfJqaoks61K6jSjqh-b4zDLtiqhNEz48wXN3IYuUaVIG606NkN-BDWnIEtJ9RIPlXDZ4ph0ThuBelB28uBPUsSDDY3Yx"
	static let authString = Self.authPrefix + " " + Self.apiKey
	
	internal enum Endpoint {
		static let base = "https://api.yelp.com/v3/businesses/search"
		
		static func addAddress(_ address: String) -> String { "location=\(address)" }
		static func addBusinessType(_ businessType: String) -> String { "term=\(businessType)" }
		
		/// Use this to end off the URL
		static let defaultRadiusAndBatchLimit = "radius=2000&sort_by=distance&limit=\(BusinessDataService.shared.batchSize)"
	}
}
