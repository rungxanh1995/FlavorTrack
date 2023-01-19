//
//  String.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import Foundation

extension String {
	/// A string with whitespaces replaced by %20 for network call purpose
	var percentEncoded: String {
		self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
	}
	
	/// Generates a localized string with format "X (the string itself) near Y".
	///
	/// Calling `"coffee".localizedDynamicString(near: "123 This Street, Toronto")` creates a localizable `"coffee near 123 This Street, Toronto"`
	func localizedDynamicString(near location: String) -> String {
		let localizedString = NSLocalizedString("%@ near %@", comment: "X business near Y location")
		return String(format: localizedString, self, location)
	}
	
	/// Generates a localized string for self.
	/// given you pass an appropriate key with 1 placeholder so that it can search from your localizabe string file.
	///
	/// Calling `"Joe".localizedDynamicString(fromKey: "Hello %@")` creates a localizable`"Hello Joe"`
	func localizedDynamicString(fromKey key: String, comment: String = "") -> String {
		let localizedString = NSLocalizedString(key, comment: comment)
		return String(format: localizedString, self)
	}
}
