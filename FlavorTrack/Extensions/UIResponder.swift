//
//  UIResponder.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//	Solution by Jonathan Rasmusson from Youtube tutorial: https://www.youtube.com/watch?v=O4tP7egAV1I&t=601s

import UIKit

extension UIResponder {

	private struct Static {
		static weak var responder: UIResponder?
	}

	/// Finds the current first responder
	/// - Returns: the current UIResponder if it exists
	static func currentFirst() -> UIResponder? {
		Static.responder = nil
		UIApplication.shared.sendAction(#selector(UIResponder.trap), to: nil, from: nil, for: nil)
		return Static.responder
	}

	@objc
	private func trap() {
		Static.responder = self
	}
}
