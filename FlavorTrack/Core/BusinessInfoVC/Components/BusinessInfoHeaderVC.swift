//
//  BusinessInfoHeaderVC.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-15.
//

import UIKit

class BusinessInfoHeaderVC: UIViewController {
	
	private let profileImageView: FTProfileImageView = .init(frame: .zero)
	private let nameLabel: FTPrimaryTitleLabel = .init(textAlignment: .left, ofSize: 28)
	private let distanceIcon: UIImageView = .init()
	private let distanceLabel: FTSecondaryTitleLabel = .init(ofSize: 19)
	private let openStatusIcon: UIImageView = .init()
	private let openStatusLabel: FTSecondaryTitleLabel = .init(ofSize: 19)
	private let costIcon: UIImageView = .init()
	private let costLabel: FTSecondaryTitleLabel = .init(ofSize: 19)
	private let underlyingCostLabel: FTSecondaryTitleLabel = .init(ofSize: 19)
	private let ratingIcon: UIImageView = .init()
	private let ratingLabel: FTSecondaryTitleLabel = .init(ofSize: 19)
	
	private var business: Business!
	
	init(for business: Business) {
		super.init(nibName: nil, bundle: nil)
		self.business = business
	}
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .systemBackground
		layoutUIElements()
		configUIElements()
		configAccessibilityForIcons()
    }
}

// MARK: - UI Configuration
private extension BusinessInfoHeaderVC {
	private func layoutUIElements() -> Void {
		view.addAllSubviewsAndDisableAutoConstraints(profileImageView, nameLabel, distanceIcon,
													 distanceLabel, openStatusIcon, openStatusLabel,
													 costIcon, costLabel, underlyingCostLabel, ratingIcon, ratingLabel)
		
		let _imgAndTextPadding: CGFloat = 12.0
		let _infoPiecePadding: CGFloat = 16.0
		let _iconSize: CGFloat = 18.0
		let _infoTextHeight: CGFloat = 22.0
		NSLayoutConstraint.activate([
			profileImageView.topAnchor.constraint(equalTo: view.topAnchor),
			profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			profileImageView.widthAnchor.constraint(equalToConstant: 90),
			profileImageView.heightAnchor.constraint(equalToConstant: 90),
			
			nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
			nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: _imgAndTextPadding),
			nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			nameLabel.heightAnchor.constraint(equalToConstant: 32),
			
			distanceIcon.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 8),
			distanceIcon.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: _imgAndTextPadding),
			distanceIcon.widthAnchor.constraint(equalToConstant: _iconSize),
			distanceIcon.heightAnchor.constraint(equalToConstant: _iconSize),
			
			distanceLabel.centerYAnchor.constraint(equalTo: distanceIcon.centerYAnchor),
			distanceLabel.leadingAnchor.constraint(equalTo: distanceIcon.trailingAnchor, constant: 6),
			distanceLabel.widthAnchor.constraint(equalToConstant: 100),
			distanceLabel.heightAnchor.constraint(equalToConstant: _infoTextHeight),
			
			openStatusIcon.centerYAnchor.constraint(equalTo: distanceIcon.centerYAnchor),
			openStatusIcon.leadingAnchor.constraint(equalTo: distanceLabel.trailingAnchor, constant: _infoPiecePadding),
			openStatusIcon.widthAnchor.constraint(equalToConstant: _iconSize),
			openStatusIcon.heightAnchor.constraint(equalToConstant: _iconSize),
			
			openStatusLabel.centerYAnchor.constraint(equalTo: openStatusIcon.centerYAnchor),
			openStatusLabel.leadingAnchor.constraint(equalTo: openStatusIcon.trailingAnchor, constant: 6),
			openStatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			openStatusLabel.heightAnchor.constraint(equalToConstant: _infoTextHeight),

			costIcon.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: _imgAndTextPadding),
			costIcon.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
			costIcon.widthAnchor.constraint(equalToConstant: _iconSize),
			costIcon.heightAnchor.constraint(equalToConstant: _iconSize),
			
			costLabel.centerYAnchor.constraint(equalTo: costIcon.centerYAnchor),
			costLabel.leadingAnchor.constraint(equalTo: costIcon.trailingAnchor, constant: 6),
			costLabel.widthAnchor.constraint(equalToConstant: 100),
			costLabel.heightAnchor.constraint(equalToConstant: _infoTextHeight),
			
			underlyingCostLabel.centerYAnchor.constraint(equalTo: costIcon.centerYAnchor),
			underlyingCostLabel.leadingAnchor.constraint(equalTo: costIcon.trailingAnchor, constant: 6),
			underlyingCostLabel.widthAnchor.constraint(equalToConstant: 100),
			underlyingCostLabel.heightAnchor.constraint(equalToConstant: _infoTextHeight),
			
			ratingIcon.centerYAnchor.constraint(equalTo: costIcon.centerYAnchor),
			ratingIcon.leadingAnchor.constraint(equalTo: costLabel.trailingAnchor, constant: _infoPiecePadding),
			ratingIcon.widthAnchor.constraint(equalToConstant: _iconSize),
			ratingIcon.heightAnchor.constraint(equalToConstant: _iconSize),
			
			ratingLabel.centerYAnchor.constraint(equalTo: ratingIcon.centerYAnchor),
			ratingLabel.leadingAnchor.constraint(equalTo: ratingIcon.trailingAnchor, constant: 6),
			ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			ratingLabel.heightAnchor.constraint(equalToConstant: _infoTextHeight)
		])
	}
	
	private func configUIElements() -> Void {
		profileImageView.downloadImage(from: business.imageURL)
		
		nameLabel.text = business.name
		
		distanceIcon.image = SFSymbols.distance
		distanceIcon.tintColor = .secondaryLabel
		distanceLabel.text = business.distance <= 1_000 ? "\(business.distance.noDecimalDigits) m away" : "\((business.distance/1000).withOneDecimalDigit) km away"
		distanceLabel.setNew(color: business.distance <= 1_000 ? .systemGreen : .systemOrange)
		
		openStatusIcon.image = business.isClosed ? SFSymbols.doorClosed : SFSymbols.doorOpen
		openStatusIcon.tintColor = .secondaryLabel
		openStatusLabel.text = business.isClosed ? "Closed" : "Open"
		openStatusLabel.setNew(color: business.isClosed ? .systemPink : .systemGreen)
		
		costIcon.image = SFSymbols.money
		costIcon.tintColor = .secondaryLabel
		costLabel.text = business.price
		underlyingCostLabel.text = "$$$$"
		underlyingCostLabel.setNew(color: .quaternaryLabel)
		
		ratingIcon.image = SFSymbols.starFilled
		ratingIcon.tintColor = .secondaryLabel
		ratingLabel.text = "\(business.rating)"
	}
	
	private func configAccessibilityForIcons() -> Void {
		distanceIcon.isAccessibilityElement = true
		distanceIcon.accessibilityLabel = "Distance"
		distanceIcon.accessibilityValue = "icon"
		
		openStatusIcon.isAccessibilityElement = true
		openStatusIcon.accessibilityLabel = "Is open or closed?"
		openStatusIcon.accessibilityValue = "icon"
		
		costIcon.isAccessibilityElement = true
		costIcon.accessibilityLabel = "Cost"
		costIcon.accessibilityValue = "icon"
		
		ratingIcon.isAccessibilityElement = true
		ratingIcon.accessibilityLabel = "Rating"
		ratingIcon.accessibilityValue = "icon"
	}
}
