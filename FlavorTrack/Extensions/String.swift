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
}
