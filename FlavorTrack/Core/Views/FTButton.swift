//
//  FTButton.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

final class FTButton: UIButton {
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	convenience init(withTitle title: String, color: UIColor = UIColor.theme.accent) {
		self.init(frame: .zero)
		setNew(title: title, withColor: color)
	}
	
	private func configure() -> Void {
		disableAutoConstraints()
		
		configuration = .tinted()
		configuration?.cornerStyle = .medium
		
		titleLabel?.font = .preferredFont(forTextStyle: .headline)
		setTitleColor(.white, for: .normal)
	}
	
	func setNew(title: String, withColor color: UIColor) {
		configuration?.title = title
		configuration?.baseBackgroundColor = color
		configuration?.baseForegroundColor = color
	}
}
