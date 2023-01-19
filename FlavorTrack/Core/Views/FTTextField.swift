//
//  FTTextField.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

final class FTTextField: UITextField {

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	init(withPlaceholder placeholder: String? = nil) {
		super.init(frame: .zero)
		configure(placeholder: placeholder)
	}
	
	
	private func configure(placeholder: String? = nil) -> Void {
		disableAutoConstraints()
		
		layer.cornerRadius = 8
		layer.borderWidth = 1
		layer.borderColor = UIColor.systemGray4.cgColor
		
		textColor = .label
		tintColor = .label
		textAlignment = .center
		font = .preferredFont(forTextStyle: .body)
		adjustsFontSizeToFitWidth = true
		minimumFontSize = 12
		
		backgroundColor = .tertiarySystemBackground
		autocorrectionType = .no
		autocapitalizationType = .none
		returnKeyType = .go
		clearButtonMode = .whileEditing
		self.placeholder = placeholder
	}

	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		
		/// Fixes border not updating its color when switching light/dark mode
		if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
			layer.borderColor = UIColor.systemGray4.cgColor
		}
	}
}
