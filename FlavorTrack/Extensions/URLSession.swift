//
//  URLSession.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-19.
//

import Foundation

extension URLSession {
	/// Asynchronously fetches data over the Internet,
	/// and returns decoded data of generic type `T`
	///
	/// - Parameter request: The pre-configured URL request (i.e. attached with OAuth key) to fetch data from
	/// - Returns: Decoded data of type `T`
	@available(iOS 15.0, *)
	func decode<T: Decodable>(from request: URLRequest) async throws -> T {
		
		let (data, response) = try await URLSession.shared.data(for: request)
		
		guard (response as? HTTPURLResponse)?.statusCode == 200 else {
			throw BusinessDataService.NetworkError.invalidResponse
		}
		
		let decoder = JSONDecoder()
		guard let decoded = try? decoder.decode(T.self, from: data) else {
			throw BusinessDataService.NetworkError.invalidData
		}
		return decoded
	}
}
