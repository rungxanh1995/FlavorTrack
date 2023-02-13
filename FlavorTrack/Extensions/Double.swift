//
//  Double.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-15.
//

import Foundation

extension Double {

	var noDecimalDigits: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .none

		let number = NSNumber(value: self)
		return formatter.string(from: number)!
	}

	var withOneDecimalDigit: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.maximumFractionDigits = 1

		let number = NSNumber(value: self)
		return formatter.string(from: number)!
	}

	/// Generates a localized string with format "X (the double itself) m from Y".
	///
	/// Calling `1_234.localizedDynamicString(awayFrom: "123 This Street, Toronto")`
	/// creates a localizable `"1.2km from 123 This Street, Toronto"`
	func localizedDynamicString(awayFrom location: String) -> String {
		var localizedString = NSLocalizedString("", comment: "")
		var formattedDistance = ""
		if self <= 1_000 {
			localizedString = NSLocalizedString("%@m from %@", comment: "X meters from location")
			formattedDistance = self.noDecimalDigits
		} else {
			localizedString = NSLocalizedString("%@km from %@", comment: "X kilometers from location")
			formattedDistance = (self / 1000).withOneDecimalDigit
		}
		return String(format: localizedString, formattedDistance, location)
	}
}
