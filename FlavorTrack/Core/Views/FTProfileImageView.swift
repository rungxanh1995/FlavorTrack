//
//  FTProfileImageView.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

class FTProfileImageView: UIImageView {
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private let placeholderImage: UIImage = AppImages.businessImgPlaceholder
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		_configure()
	}
	
	private func _configure() -> Void {
		disableAutoConstraints()

		image = placeholderImage
		layer.masksToBounds = false
		layer.borderWidth = 1
		layer.borderColor = UIColor.systemGray4.cgColor
		clipsToBounds = true
	}
	
	override func layoutSubviews() {
		layer.cornerRadius = frame.height / 2 /// make image circular
	}
}

extension FTProfileImageView {
	func downloadImage(from urlString: String) -> Void {
		Task {
			image = await ImageDataService.shared.downloadOrGetFromCache(from: urlString)
		}
	}
}
