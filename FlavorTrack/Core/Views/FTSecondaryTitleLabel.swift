//
//  FTSecondaryTitleLabel.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

class FTSecondaryTitleLabel: UILabel {

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override init(frame: CGRect) {
		super.init(frame: frame)
		_configure()
	}
	
	convenience init(ofSize size: CGFloat) {
		self.init(frame: .zero)
		font = .systemFont(ofSize: size, weight: .medium)
	}
	
	private func _configure() {
		disableAutoConstraints()

		textColor = .secondaryLabel
		adjustsFontSizeToFitWidth = true
		minimumScaleFactor = 0.9
		lineBreakMode = .byTruncatingTail
	}
	
	func setNew(color: UIColor) -> Void {
		textColor = color
	}
}
