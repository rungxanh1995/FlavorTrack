//
//  FTSecondaryTitleLabel.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

final class FTSecondaryTitleLabel: UILabel {

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}

	convenience init(ofSize size: CGFloat) {
		self.init(frame: .zero)
		font = .systemFont(ofSize: size, weight: .medium)
	}

	private func configure() {
		disableAutoConstraints()

		textColor = .secondaryLabel
		adjustsFontSizeToFitWidth = false
		minimumScaleFactor = 1.0
		lineBreakMode = .byTruncatingTail
	}

	func setNew(color: UIColor) {
		textColor = color
	}
}
