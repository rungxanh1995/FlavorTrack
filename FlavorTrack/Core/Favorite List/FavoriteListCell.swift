//
//  FavoriteListCell.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-16.
//

import UIKit

class FavoriteListCell: UITableViewCell {

	/// Reusable identifier of the cell
	static let REUSE_ID = "FavoriteCell"
	
	private let profileImageView: FTProfileImageView = .init(frame: .zero)
	private let nameLabel: FTPrimaryTitleLabel = .init(textAlignment: .left, ofSize: 17)

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
	}
	
	private func configure() -> Void {
		accessoryType = .detailButton
		
		let _cellPadding: CGFloat = 12.0
		addAllSubviewsAndDisableAutoConstraints(profileImageView, nameLabel)
		NSLayoutConstraint.activate([
			profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: _cellPadding),
			profileImageView.heightAnchor.constraint(equalToConstant: 60),
			profileImageView.widthAnchor.constraint(equalToConstant: 60),
			
			nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: _cellPadding),
			nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(_cellPadding)),
			nameLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}
	
	func set(with favorite: Business) {
		nameLabel.text = favorite.name
		profileImageView.downloadImage(from: favorite.imageURL)
	}
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
