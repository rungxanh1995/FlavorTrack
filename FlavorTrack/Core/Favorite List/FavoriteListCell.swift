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
		let _cellPadding: CGFloat = 12.0
		let _imgAndTextPadding: CGFloat = 12.0
		let _infoPiecePadding: CGFloat = 10.0
		let _iconSize: CGFloat = 16.0
		let _infoTextHeight: CGFloat = 18.0
		#warning("Using a hack for nameLabel & tagLabel to workaround accessoryType overlapping them")
		NSLayoutConstraint.activate([
			profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: _cellPadding),
			profileImageView.heightAnchor.constraint(equalToConstant: 44),
			profileImageView.widthAnchor.constraint(equalToConstant: 44),
			
			nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
			nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: _imgAndTextPadding),
			nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(_cellPadding * 4)),
			nameLabel.heightAnchor.constraint(equalToConstant: 20),
			
			ratingIcon.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
			ratingIcon.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: _imgAndTextPadding),
			ratingIcon.widthAnchor.constraint(equalToConstant: _iconSize),
			ratingIcon.heightAnchor.constraint(equalToConstant: _iconSize),
			
			ratingLabel.centerYAnchor.constraint(equalTo: ratingIcon.centerYAnchor),
			ratingLabel.leadingAnchor.constraint(equalTo: ratingIcon.trailingAnchor, constant: 6),
			ratingLabel.widthAnchor.constraint(equalToConstant: 32),
			ratingLabel.heightAnchor.constraint(equalToConstant: _infoTextHeight),
			
			tagIcon.centerYAnchor.constraint(equalTo: ratingIcon.centerYAnchor),
			tagIcon.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: _infoPiecePadding),
			tagIcon.widthAnchor.constraint(equalToConstant: _iconSize),
			tagIcon.heightAnchor.constraint(equalToConstant: _iconSize),
			
			tagLabel.centerYAnchor.constraint(equalTo: tagIcon.centerYAnchor),
			tagLabel.leadingAnchor.constraint(equalTo: tagIcon.trailingAnchor, constant: 6),
			tagLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(_cellPadding * 4)),
			tagLabel.heightAnchor.constraint(equalToConstant: _infoTextHeight)
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
