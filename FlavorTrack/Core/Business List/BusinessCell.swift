//
//  BusinessCell.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

final class BusinessCell: UICollectionViewCell {
	/// Reusable identifier of the cell
	static let REUSE_ID = "BusinessCell"
	
	private let profileImageView: FTProfileImageView = .init(frame: .zero)
	private let businessNameLabel: FTPrimaryTitleLabel = .init(textAlignment: .center, ofSize: 13)
	private let _padding: CGFloat = 4.0
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	func set(with business: Business) -> Void {
		businessNameLabel.text = business.name
		profileImageView.downloadImage(from: business.imageURL)
	}
	
	private func configure() -> Void {
		addAllSubviews(profileImageView, businessNameLabel)
		
		NSLayoutConstraint.activate([
			profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: _padding),
			profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: _padding),
			profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(_padding)),
			profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
			
			businessNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
			businessNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: _padding),
			businessNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(_padding)),
			businessNameLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
