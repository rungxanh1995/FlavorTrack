//
//  FTAlertContainerView.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

class FTAlertContainerView: UIView {

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	private func configure() -> Void {
		disableAutoConstraints()
		backgroundColor = .secondarySystemBackground
		layer.cornerRadius = 16
		layer.borderWidth = 1
		layer.borderColor = UIColor.systemGray4.cgColor
	}

	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		
		/// Fixes border not updating its color when switching light/dark mode
		if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
			layer.borderColor = UIColor.systemGray4.cgColor
		}
	}
}
