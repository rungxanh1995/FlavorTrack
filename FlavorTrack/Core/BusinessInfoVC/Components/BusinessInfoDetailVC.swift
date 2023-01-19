//
//  BusinessInfoDetailVC.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-15.
//

import UIKit

final class BusinessInfoDetailVC: UIViewController {
	
	private let locationIcon: UIImageView = .init()
	private let locationLabel: FTBodyLabel = .init(textAlignment: .left)
	private let phoneIcon: UIImageView = .init()
	private let phoneLabel: FTBodyLabel = .init(textAlignment: .left)
	private let tagIcon: UIImageView = .init()
	private let tagLabel: FTBodyLabel = .init(textAlignment: .left)
	private let linkIcon: UIImageView = .init()
	private let linkLabel: FTBodyLabel = .init(textAlignment: .left)

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

private extension BusinessInfoDetailVC {
	private func layoutUIElements() -> Void {
		view.addAllSubviewsAndDisableAutoConstraints(locationIcon, locationLabel, phoneIcon,
													 phoneLabel, tagIcon, tagLabel, linkIcon, linkLabel)
		
		let imgAndTextPadding: CGFloat = 6.0
		let infoPiecePadding: CGFloat = 16.0
		let iconSize: CGFloat = 18.0
		let infoTextHeight: CGFloat = 22.0
		
		locationIcon.constrainSizeToConstant(iconSize)
		phoneIcon.constrainSizeToConstant(iconSize)
		tagIcon.constrainSizeToConstant(iconSize)
		linkIcon.constrainSizeToConstant(iconSize)
		
		NSLayoutConstraint.activate([
			locationIcon.topAnchor.constraint(equalTo: view.topAnchor),
			locationIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			
			locationLabel.centerYAnchor.constraint(equalTo: locationIcon.centerYAnchor),
			locationLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: imgAndTextPadding),
			locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			locationLabel.heightAnchor.constraint(equalToConstant: infoTextHeight),
			
			phoneIcon.topAnchor.constraint(equalTo: locationIcon.bottomAnchor, constant: infoPiecePadding),
			phoneIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			
			phoneLabel.centerYAnchor.constraint(equalTo: phoneIcon.centerYAnchor),
			phoneLabel.leadingAnchor.constraint(equalTo: phoneIcon.trailingAnchor, constant: imgAndTextPadding),
			phoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			phoneLabel.heightAnchor.constraint(equalToConstant: infoTextHeight),
			
			tagIcon.topAnchor.constraint(equalTo: phoneIcon.bottomAnchor, constant: infoPiecePadding),
			tagIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			
			tagLabel.centerYAnchor.constraint(equalTo: tagIcon.centerYAnchor),
			tagLabel.leadingAnchor.constraint(equalTo: tagIcon.trailingAnchor, constant: imgAndTextPadding),
			tagLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tagLabel.heightAnchor.constraint(equalToConstant: infoTextHeight),
			
			linkIcon.topAnchor.constraint(equalTo: tagIcon.bottomAnchor, constant: infoPiecePadding),
			linkIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			
			linkLabel.centerYAnchor.constraint(equalTo: linkIcon.centerYAnchor),
			linkLabel.leadingAnchor.constraint(equalTo: linkIcon.trailingAnchor, constant: imgAndTextPadding),
			linkLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			linkLabel.heightAnchor.constraint(equalToConstant: infoTextHeight)
		])
	}
	
	private func configUIElements() -> Void {
		// Location
		locationIcon.image = SFSymbols.mapPin
		locationIcon.tintColor = .secondaryLabel
		locationLabel.text = business.location?.displayAddress?.joined(separator: ", ") ?? NSLocalizedString("No address information available", comment: "")
		
		// Phone
		phoneIcon.image = SFSymbols.phone
		phoneIcon.tintColor = .secondaryLabel
		switch business.displayPhone {
			case .none:
				phoneLabel.text = NSLocalizedString("No phone number available", comment: "")
			case .some(let phoneNo):
				phoneLabel.text = phoneNo.isEmpty ? NSLocalizedString("No phone number available", comment: "") : phoneNo
		}
		
		// Tags
		tagIcon.image = SFSymbols.tag
		tagIcon.tintColor = .secondaryLabel
		tagLabel.text = business.readableCategories
		
		// Link
		linkIcon.image = SFSymbols.globe
		linkIcon.tintColor = .secondaryLabel
		
		let yelpAttrString = NSMutableAttributedString(string: NSLocalizedString("Find out more on Yelp", comment: ""))
		yelpAttrString.addAttribute(.link, value: business.yelpUrl, range: NSRange(location: 0, length: yelpAttrString.length))
		linkLabel.attributedText = yelpAttrString
		linkLabel.isUserInteractionEnabled = true
		linkLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(yelpUrlTapped)))
	}
	
	private func configAccessibilityForIcons() -> Void {
		locationIcon.isAccessibilityElement = true
		locationIcon.accessibilityLabel = NSLocalizedString("Location", comment: "")
		locationIcon.accessibilityValue = "icon"
		
		phoneIcon.isAccessibilityElement = true
		phoneIcon.accessibilityLabel = NSLocalizedString("Phone number", comment: "")
		phoneIcon.accessibilityValue = "icon"
		
		tagIcon.isAccessibilityElement = true
		tagIcon.accessibilityLabel = NSLocalizedString("Categories", comment: "")
		tagIcon.accessibilityValue = "icon"
		
		linkIcon.isAccessibilityElement = true
		linkIcon.accessibilityLabel = NSLocalizedString("Website URL", comment: "")
		linkIcon.accessibilityValue = "icon"
	}
	
	@objc
	private func yelpUrlTapped(_ sender: UITapGestureRecognizer) {
		guard let url = URL(string: business.yelpUrl) else { return }
		UIApplication.shared.open(url)
	}
}
