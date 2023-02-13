//
//  FTBodyLabel.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

final class FTBodyLabel: UILabel {

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}

	convenience init(textAlignment: NSTextAlignment) {
		self.init(frame: .zero)
		self.textAlignment = textAlignment
		self.font = .preferredFont(forTextStyle: .body)
	}

	private func configure() {
		disableAutoConstraints()

		textColor = .secondaryLabel
		adjustsFontSizeToFitWidth = false
		minimumScaleFactor = 1.0
		lineBreakMode = .byTruncatingTail
	}
}
