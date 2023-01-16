//
//  BusinessInfoDetailVC.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-15.
//

import UIKit

class BusinessInfoDetailVC: UIViewController {
	
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
		
		let _imgAndTextPadding: CGFloat = 12.0
		let _infoPiecePadding: CGFloat = 16.0
		let _iconSize: CGFloat = 18.0
		let _infoTextHeight: CGFloat = 22.0
		NSLayoutConstraint.activate([
			locationIcon.topAnchor.constraint(equalTo: view.topAnchor),
			locationIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			locationIcon.widthAnchor.constraint(equalToConstant: _iconSize),
			locationIcon.heightAnchor.constraint(equalToConstant: _iconSize),
			
			locationLabel.centerYAnchor.constraint(equalTo: locationIcon.centerYAnchor),
			locationLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: _imgAndTextPadding),
			locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			locationLabel.heightAnchor.constraint(equalToConstant: _infoTextHeight),
			
			phoneIcon.topAnchor.constraint(equalTo: locationIcon.bottomAnchor, constant: _infoPiecePadding),
			phoneIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			phoneIcon.widthAnchor.constraint(equalToConstant: _iconSize),
			phoneIcon.heightAnchor.constraint(equalToConstant: _iconSize),
			
			phoneLabel.centerYAnchor.constraint(equalTo: phoneIcon.centerYAnchor),
			phoneLabel.leadingAnchor.constraint(equalTo: phoneIcon.trailingAnchor, constant: _imgAndTextPadding),
			phoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			phoneLabel.heightAnchor.constraint(equalToConstant: _infoTextHeight),
			
			tagIcon.topAnchor.constraint(equalTo: phoneIcon.bottomAnchor, constant: _infoPiecePadding),
			tagIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tagIcon.widthAnchor.constraint(equalToConstant: _iconSize),
			tagIcon.heightAnchor.constraint(equalToConstant: _iconSize),
			
			tagLabel.centerYAnchor.constraint(equalTo: tagIcon.centerYAnchor),
			tagLabel.leadingAnchor.constraint(equalTo: tagIcon.trailingAnchor, constant: _imgAndTextPadding),
			tagLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tagLabel.heightAnchor.constraint(equalToConstant: _infoTextHeight),
			
			linkIcon.topAnchor.constraint(equalTo: tagIcon.bottomAnchor, constant: _infoPiecePadding),
			linkIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			linkIcon.widthAnchor.constraint(equalToConstant: _iconSize),
			linkIcon.heightAnchor.constraint(equalToConstant: _iconSize),
			
			linkLabel.centerYAnchor.constraint(equalTo: linkIcon.centerYAnchor),
			linkLabel.leadingAnchor.constraint(equalTo: linkIcon.trailingAnchor, constant: _imgAndTextPadding),
			linkLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			linkLabel.heightAnchor.constraint(equalToConstant: _infoTextHeight)
		])
	}
	
	private func configUIElements() -> Void {
		locationIcon.image = SFSymbols.mapPin
		locationIcon.tintColor = .secondaryLabel
		locationLabel.text = business.location?.displayAddress?.joined(separator: ", ") ?? "No address information available"
		locationLabel.isUserInteractionEnabled = false
		
		phoneIcon.image = SFSymbols.phone
		phoneIcon.tintColor = .secondaryLabel
		switch business.displayPhone {
			case .none:
				phoneLabel.text = "No phone number available"
			case .some(let phoneNo):
				phoneLabel.text = phoneNo.isEmpty ? "No phone number available" : phoneNo
		}
		phoneLabel.isUserInteractionEnabled = false
		
		tagIcon.image = SFSymbols.tag
		tagIcon.tintColor = .secondaryLabel
		
		var tags: [String] = []
		for eachCategory in business.categories {
			if let tag = eachCategory.title {
				tags.append(tag)
			}
		}
		tagLabel.text = tags.joined(separator: ", ")
		
		linkIcon.image = SFSymbols.globe
		linkIcon.tintColor = .secondaryLabel
		linkLabel.text = business.yelpUrl
		linkLabel.isUserInteractionEnabled = false
	}
	
	private func configAccessibilityForIcons() -> Void {
		locationIcon.isAccessibilityElement = true
		locationIcon.accessibilityLabel = "Location"
		locationIcon.accessibilityValue = "icon"
		
		phoneIcon.isAccessibilityElement = true
		phoneIcon.accessibilityLabel = "Phone number"
		phoneIcon.accessibilityValue = "icon"
		
		tagIcon.isAccessibilityElement = true
		tagIcon.accessibilityLabel = "Categories"
		tagIcon.accessibilityValue = "icon"
		
		linkIcon.isAccessibilityElement = true
		linkIcon.accessibilityLabel = "Website URL"
		linkIcon.accessibilityValue = "icon"
	}
}
