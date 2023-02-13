//
//  FTEmptyStateView.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

final class GHEmptyStateView: UIView {

	private let logoImageView: UIImageView = .init()
	private let messageLabel: FTPrimaryTitleLabel = .init(textAlignment: .center, ofSize: 24)

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}

	convenience init(message: String) {
		self.init(frame: .zero)
		backgroundColor = .systemBackground
		messageLabel.text = NSLocalizedString(message, comment: "The text of the empty state view")
	}

	private func configure() {
		addSubview(logoImageView)
		addSubview(messageLabel)

		messageLabel.numberOfLines = 3
		messageLabel.textColor = .secondaryLabel

		logoImageView.image = AppImages.emptyStateLogo
		logoImageView.disableAutoConstraints()

		messageLabel.constrainToLeadingAndTrailingAnchors(of: self, padding: 40.0)

		// extra constraints
		NSLayoutConstraint.activate([
			messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
			messageLabel.heightAnchor.constraint(equalToConstant: 200),

			logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
			logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
			logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
			logoImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 40)
		])
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
