//
//  UIColor.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

extension UIColor {
	static let theme: AppColorTheme = .init()
}

struct AppColorTheme {
	let accent: UIColor = .init(named: "AccentColor")!
}
