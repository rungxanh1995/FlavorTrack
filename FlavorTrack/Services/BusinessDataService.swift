//
//  BusinessDataService.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import Foundation

final class BusinessDataService {
	static let shared: BusinessDataService = .init()
	private init() {}
	
	let batchSize: Int = 50
	
	func getBusinessList(nearby address: String, businessType: String,
						 onComplete: @escaping (Result<[Business], BusinessDataService.NetworkError>) -> Void) {
		let endpoint = "\(ApiConstants.Endpoint.base)?\(ApiConstants.Endpoint.addAddress(address.percentEncoded))&\(ApiConstants.Endpoint.addBusinessType(businessType.percentEncoded))&\(ApiConstants.Endpoint.defaultRadiusAndBatchLimit)"
		
		guard let url = URL(string: endpoint) else {
			onComplete(.failure(.invalidInputs))
			return
		}
		
		var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
		let headers = [
		  "accept": "application/json",
		  "Authorization": ApiConstants.authString
		]
		request.allHTTPHeaderFields = headers
		request.httpMethod = "GET"

		URLSession.shared.dataTask(with: request) { data, response, error in
			if error != nil {
				onComplete(.failure(.unableToComplete))
				return
			}
			
			guard let response = response as? HTTPURLResponse,
				  response.statusCode == 200 else {
				onComplete(.failure(.invalidResponse))
				return
			}
			
			guard let data else {
				onComplete(.failure(.invalidData))
				return
			}
			
			do {
				let decoder = JSONDecoder()
				let rawResponse = try decoder.decode(RawServerResponse.self, from: data)
				onComplete(.success(rawResponse.businesses))
			} catch {
				onComplete(.failure(.invalidData))
			}
		}
		.resume()
	}
}

extension BusinessDataService {
	internal enum NetworkError: String, Error {
		case invalidInputs = "The inputs created an invalid request. Please retry."
		case unableToComplete = "Unable to complete your request. Please check your internet connection."
		case invalidResponse = "Invalid response from server. Please retry."
		case invalidData = "Invalid data received from server. Please retry."
	}
}
