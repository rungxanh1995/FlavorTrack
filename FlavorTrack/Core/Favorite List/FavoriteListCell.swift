//
//  FavoriteListCell.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-16.
//

import UIKit

final class FavoriteListCell: UITableViewCell {

	/// Reusable identifier of the cell
	static let REUSE_ID = "FavoriteCell"
	
	private let profileImageView: FTProfileImageView = .init(frame: .zero)
	private let nameLabel: FTPrimaryTitleLabel = .init(textAlignment: .left, ofSize: 17)
	private let ratingIcon: UIImageView = .init()
	private let ratingLabel: FTBodyLabel = .init(textAlignment: .left)
	private let tagIcon: UIImageView = .init()
	private let tagLabel: FTBodyLabel = .init(textAlignment: .left)

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
		configAccessibilityForIcons()
	}
	
	private func configure() -> Void {
		accessoryType = .detailButton
		
		addAllSubviewsAndDisableAutoConstraints(profileImageView, nameLabel, ratingIcon,
												ratingLabel, tagIcon, tagLabel)
		let cellPadding: CGFloat = 12.0
		let imgAndTextPadding: CGFloat = 12.0
		let infoPiecePadding: CGFloat = 10.0
		let iconSize: CGFloat = 16.0
		let infoTextHeight: CGFloat = 18.0
		
		
		profileImageView.constrainSizeToConstant(44.0)
		ratingIcon.constrainSizeToConstant(iconSize)
		tagIcon.constrainSizeToConstant(iconSize)
		
		// extra constraints
		// using a hack for nameLabel & tagLabel trailing padding to workaround accessoryType overlapping them
		NSLayoutConstraint.activate([
			profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: cellPadding),
			
			nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
			nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: imgAndTextPadding),
			nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(cellPadding * 4)),
			nameLabel.heightAnchor.constraint(equalToConstant: 20),
			
			ratingIcon.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
			ratingIcon.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: imgAndTextPadding),
			
			ratingLabel.centerYAnchor.constraint(equalTo: ratingIcon.centerYAnchor),
			ratingLabel.leadingAnchor.constraint(equalTo: ratingIcon.trailingAnchor, constant: 6),
			ratingLabel.widthAnchor.constraint(equalToConstant: 32),
			ratingLabel.heightAnchor.constraint(equalToConstant: infoTextHeight),
			
			tagIcon.centerYAnchor.constraint(equalTo: ratingIcon.centerYAnchor),
			tagIcon.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: infoPiecePadding),
			
			tagLabel.centerYAnchor.constraint(equalTo: tagIcon.centerYAnchor),
			tagLabel.leadingAnchor.constraint(equalTo: tagIcon.trailingAnchor, constant: 6),
			tagLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(cellPadding * 4)),
			tagLabel.heightAnchor.constraint(equalToConstant: infoTextHeight)
		])
	}
	
	func set(with favorite: Business) {
		profileImageView.downloadImage(from: favorite.imageURL)
		nameLabel.text = favorite.name
		
		ratingIcon.image = SFSymbols.starFilled
		ratingIcon.tintColor = .systemYellow
		ratingLabel.text = "\(favorite.rating)"
		
		tagIcon.image = SFSymbols.tag
		tagIcon.tintColor = UIColor.theme.accent
		tagLabel.text = favorite.readableCategories
	}
	
	private func configAccessibilityForIcons() -> Void {
		ratingIcon.isAccessibilityElement = true
		ratingIcon.accessibilityLabel = NSLocalizedString("Rating", comment: "The noun")
		ratingIcon.accessibilityValue = "icon"
		
		tagIcon.isAccessibilityElement = true
		tagIcon.accessibilityLabel = NSLocalizedString("Categories", comment: "")
		tagIcon.accessibilityValue = "icon"
	}
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
