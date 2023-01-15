//
//  UIView.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

extension UIView {
	
	/// Disable a view's autoresizing mask being translated into Auto Layout constraints.
	///
	/// After this call, you MUST set the constraints programmatically!
	func disableAutoConstraints() -> Void { translatesAutoresizingMaskIntoConstraints = false }
	
	func addAllSubviews(_ subviews: UIView...) -> Void {
		for subview in subviews {
			addSubview(subview)
		}
	}
	
	/// After this call, you MUST set the constraints programmatically!
	func addAllSubviewsAndDisableAutoConstraints(_ subviews: UIView...) -> Void {
		for subview in subviews {
			addSubview(subview)
			subview.disableAutoConstraints()
		}
	}
}

