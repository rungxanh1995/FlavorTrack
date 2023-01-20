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
	
	/// Fetch data of generic type `T` that conforms to the `Decodable` protocol, from a specific nearby address and business type.
	///
	/// Example usage:
	/// ```
	/// BusinessDataService.shared.fetchData(nearby: location, businessType: businessType) { (result: Result<RawServerResponse, BusinessDataService.NetworkError>) in
	/// 	switch result {
	/// 	case .success(let decoded):
	/// 		self.updateUI(with: decoded.businesses)
	/// 	case .failure(let error):
	/// 		self.presentAlert(message: error.rawValue)
	///		}
	/// ```
	/// - Parameters:
	/// 	- nearby: A string representing the nearby address.
	/// 	- businessType: A string representing the business type.
	/// 	- onComplete: A completion handler that takes in a `Result<T, BusinessDataService.NetworkError>` object.
	func fetchData<T: Decodable>(nearby address: String, businessType: String,
								 onComplete: @escaping (Result<T, BusinessDataService.NetworkError>) -> Void) -> Void {
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
			
			let decoder = JSONDecoder()
			guard let decoded = try? decoder.decode(T.self, from: data) else {
				onComplete(.failure(.invalidData))
				return
			}
			
			onComplete(.success(decoded))
		}
		.resume()
	}
	
	@available(iOS 15.0, *)
	func fetchData<T: Decodable>(nearby address: String, businessType: String) async throws -> T {
		let endpoint = "\(ApiConstants.Endpoint.base)?\(ApiConstants.Endpoint.addAddress(address.percentEncoded))&\(ApiConstants.Endpoint.addBusinessType(businessType.percentEncoded))&\(ApiConstants.Endpoint.defaultRadiusAndBatchLimit)"
		
		guard let url = URL(string: endpoint) else { throw NetworkError.invalidInputs }

		var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
		let headers = [
			"accept": "application/json",
			"Authorization": ApiConstants.authString
		]
		request.allHTTPHeaderFields = headers
		request.httpMethod = "GET"
		
		do {
			// Cast to `RawServerResponse` type due to the JSON structure returned from Yelp API
			let decodedResponse: RawServerResponse = try await URLSession.shared.decode(from: request)
			return decodedResponse.businesses as! T
		} catch let error {
			throw error
		}
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
