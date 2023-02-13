//
//  UIHelper.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

enum UIHelper {

	static func makeThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
		let screenWidth = view.bounds.width
		let padding: CGFloat = 12.0
		let minItemSpacing: CGFloat = 10.0 // changing this may lead to unexpected layout bug
		let availWidth: CGFloat = screenWidth - (padding * 2) - (minItemSpacing * 2)
		let itemWidth: CGFloat = availWidth / 3

		let layout: UICollectionViewFlowLayout = .init()
		layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
		return layout
	}
}
