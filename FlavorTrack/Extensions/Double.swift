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
}
