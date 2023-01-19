//
//  ImageDataService.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

final class ImageDataService {
	static let shared: ImageDataService = .init()
	private init() {}
	
	private let cache: NSCache<NSString, UIImage> = .init()

	func downloadOrGetFromCache(from urlString: String, onComplete: @escaping (UIImage?) -> Void) -> Void {
		let _cacheKey = NSString(string: urlString)
		// Access cached image if exists
		if let image = cache.object(forKey: _cacheKey) {
			onComplete(image)
			return
		}
		
		// otherwise, download and cache
		guard let url = URL(string: urlString) else { return }
		URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			guard error == nil,
				  let response = response as? HTTPURLResponse,
				  response.statusCode >= 200 && response.statusCode < 300,
				  let data,
				  let image = UIImage(data: data) else {
				onComplete(nil)
				return
			}
			self?.cache.setObject(image, forKey: _cacheKey)
			onComplete(image)
		}
		.resume()
	}
	
	@available(iOS 15.0, *)
	func downloadOrGetFromCache(from urlString: String) async -> UIImage? {
		let _cacheKey = NSString(string: urlString)
		// Access cached image if exists
		if let image = cache.object(forKey: _cacheKey) { return image }
		
		// otherwise, download and cache
		guard let url = URL(string: urlString) else { return nil }
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			guard let image = UIImage(data: data) else { return nil }
			cache.setObject(image, forKey: _cacheKey)
			return image
		} catch { return nil }
	}
}
