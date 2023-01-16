//
//  FTMapView.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-15.
//

import UIKit

class FTMapView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func configure() -> Void {
		layer.borderWidth = 1
		layer.borderColor = UIColor.systemGray4.cgColor
		layer.masksToBounds = false
		clipsToBounds = true
		
		disableAutoConstraints()
	}
	
	override func layoutSubviews() {
		layer.cornerRadius = 8.0
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		
		/// Fixes border not updating its color when switching light/dark mode
		if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
			layer.borderColor = UIColor.systemGray4.cgColor
		}
	}
}
