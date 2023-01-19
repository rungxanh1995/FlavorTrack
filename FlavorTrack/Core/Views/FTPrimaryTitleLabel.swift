//
//  FTPrimaryTitleLabel.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

final class FTPrimaryTitleLabel: UILabel {

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override init(frame: CGRect) {
		super.init(frame: frame)
		_configure()
	}
	
	convenience init(textAlignment: NSTextAlignment, ofSize fontSize: CGFloat) {
		self.init(frame: .zero)
		self.textAlignment = textAlignment
		self.font = .systemFont(ofSize: fontSize, weight: .bold)
	}
	
	private func _configure() {
		disableAutoConstraints()

		textColor = .label
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.9
		lineBreakMode = .byTruncatingTail
	}
}
