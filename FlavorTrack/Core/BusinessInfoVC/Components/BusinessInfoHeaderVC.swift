//
//  BusinessInfoHeaderVC.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-15.
//

import UIKit

final class BusinessInfoHeaderVC: UIViewController {
	
	private let profileImageView: FTProfileImageView = .init(frame: .zero)
	private let nameLabel: FTPrimaryTitleLabel = .init(textAlignment: .natural, ofSize: 28)
	private let distanceIcon: UIImageView = .init()
	private let distanceLabel: FTSecondaryTitleLabel = .init(ofSize: 17)
	private let openStatusIcon: UIImageView = .init()
	private let openStatusLabel: FTSecondaryTitleLabel = .init(ofSize: 17)
	private let costIcon: UIImageView = .init()
	private let costLabel: FTSecondaryTitleLabel = .init(ofSize: 17)
	private let underlyingCostLabel: FTSecondaryTitleLabel = .init(ofSize: 17)
	private let ratingIcon: UIImageView = .init()
	private let ratingLabel: FTSecondaryTitleLabel = .init(ofSize: 17)
	
	private var business: Business!
	private var searchedLocation: String!
	
	init(for business: Business, near location: String) {
		super.init(nibName: nil, bundle: nil)
		self.business = business
		self.searchedLocation = location
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
		
		let imgAndTextPadding: CGFloat = 12.0
		let infoPiecePadding: CGFloat = 10.0
		let iconSize: CGFloat = 18.0
		let infoTextHeight: CGFloat = 22.0
		NSLayoutConstraint.activate([
			profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
			profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			profileImageView.widthAnchor.constraint(equalToConstant: 90),
			profileImageView.heightAnchor.constraint(equalToConstant: 90),
			
			nameLabel.topAnchor.constraint(equalTo: view.topAnchor),
			nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: imgAndTextPadding),
			nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			nameLabel.heightAnchor.constraint(equalToConstant: 32),
			
			distanceIcon.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: infoPiecePadding),
			distanceIcon.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: imgAndTextPadding),
			distanceIcon.widthAnchor.constraint(equalToConstant: iconSize),
			distanceIcon.heightAnchor.constraint(equalToConstant: iconSize),
			
			distanceLabel.centerYAnchor.constraint(equalTo: distanceIcon.centerYAnchor),
			distanceLabel.leadingAnchor.constraint(equalTo: distanceIcon.trailingAnchor, constant: 6),
			distanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			distanceLabel.heightAnchor.constraint(equalToConstant: infoTextHeight),
			
			openStatusIcon.topAnchor.constraint(equalTo: distanceIcon.bottomAnchor, constant: infoPiecePadding),
			openStatusIcon.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: imgAndTextPadding),
			openStatusIcon.widthAnchor.constraint(equalToConstant: iconSize),
			openStatusIcon.heightAnchor.constraint(equalToConstant: iconSize),
			
			openStatusLabel.centerYAnchor.constraint(equalTo: openStatusIcon.centerYAnchor),
			openStatusLabel.leadingAnchor.constraint(equalTo: openStatusIcon.trailingAnchor, constant: 6),
			openStatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			openStatusLabel.heightAnchor.constraint(equalToConstant: infoTextHeight),

			costIcon.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: imgAndTextPadding),
			costIcon.topAnchor.constraint(equalTo: openStatusIcon.bottomAnchor, constant: infoPiecePadding),
			costIcon.widthAnchor.constraint(equalToConstant: iconSize),
			costIcon.heightAnchor.constraint(equalToConstant: iconSize),
			
			costLabel.centerYAnchor.constraint(equalTo: costIcon.centerYAnchor),
			costLabel.leadingAnchor.constraint(equalTo: costIcon.trailingAnchor, constant: 6),
			costLabel.widthAnchor.constraint(equalToConstant: 56),
			costLabel.heightAnchor.constraint(equalToConstant: infoTextHeight),
			
			underlyingCostLabel.centerYAnchor.constraint(equalTo: costIcon.centerYAnchor),
			underlyingCostLabel.leadingAnchor.constraint(equalTo: costIcon.trailingAnchor, constant: 6),
			underlyingCostLabel.widthAnchor.constraint(equalToConstant: 56),
			underlyingCostLabel.heightAnchor.constraint(equalToConstant: infoTextHeight),
			
			ratingIcon.centerYAnchor.constraint(equalTo: costIcon.centerYAnchor),
			ratingIcon.leadingAnchor.constraint(equalTo: costLabel.trailingAnchor, constant: infoPiecePadding),
			ratingIcon.widthAnchor.constraint(equalToConstant: iconSize),
			ratingIcon.heightAnchor.constraint(equalToConstant: iconSize),
			
			ratingLabel.centerYAnchor.constraint(equalTo: ratingIcon.centerYAnchor),
			ratingLabel.leadingAnchor.constraint(equalTo: ratingIcon.trailingAnchor, constant: 6),
			ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			ratingLabel.heightAnchor.constraint(equalToConstant: infoTextHeight)
		])
	}
	
	private func configUIElements() -> Void {
		profileImageView.downloadImage(from: business.imageURL)
		
		nameLabel.text = business.name
		
		distanceIcon.image = SFSymbols.distance
		distanceIcon.tintColor = .secondaryLabel
		distanceLabel.text = business.distance <= 1_000 ?
			"\(business.distance.noDecimalDigits)m from \(searchedLocation!)" :
			"\((business.distance/1000).withOneDecimalDigit)km from \(searchedLocation!)"
		distanceLabel.setNew(color: business.distance <= 1_000 ? .systemGreen : .systemOrange)
		
		openStatusIcon.image = business.isClosed ? SFSymbols.doorClosed : SFSymbols.doorOpen
		openStatusIcon.tintColor = .secondaryLabel
		openStatusLabel.text = business.isClosed ? "Closed from Public" : "Open to Public"
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
