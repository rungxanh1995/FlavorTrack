//
//  UIHelper.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

enum UIHelper {
	
	static func makeThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
		let _screenWidth = view.bounds.width
		let _padding: CGFloat = 12.0
		let _minItemSpacing: CGFloat = 10.0 // changing this may lead to unexpected layout bug
		let _availWidth: CGFloat = _screenWidth - (_padding * 2) - (_minItemSpacing * 2)
		let _itemWidth: CGFloat = _availWidth / 3
		
		let layout: UICollectionViewFlowLayout = .init()
		layout.sectionInset = UIEdgeInsets(top: _padding, left: _padding, bottom: _padding, right: _padding)
		layout.itemSize = CGSize(width: _itemWidth, height: _itemWidth + 40)
		return layout
	}
}
