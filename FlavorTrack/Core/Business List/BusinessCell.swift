//
//  BusinessCell.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

final class BusinessCell: UICollectionViewCell {
	/// Reusable identifier of the cell
	static let reuseIdentifier = "BusinessCell"

	private let profileImageView: FTProfileImageView = .init(frame: .zero)
	private let businessNameLabel: FTPrimaryTitleLabel = .init(textAlignment: .center, ofSize: 13)
	private let edgePadding: CGFloat = 4.0

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}

	func set(with business: Business) {
		businessNameLabel.text = business.name
		profileImageView.downloadImage(from: business.imageURL)
	}

	private func configure() {
		addAllSubviews(profileImageView, businessNameLabel)

		profileImageView.constrainToUpperHalf(of: self, padding: edgePadding)
		businessNameLabel.constrainToLeadingAndTrailingAnchors(of: self, padding: edgePadding)

		// extra constraints
		NSLayoutConstraint.activate([
			profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
			businessNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
			businessNameLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
