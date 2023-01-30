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
	
	func addAllSubviews(_ subviews: UIView...) {
		for subview in subviews {
			addSubview(subview)
		}
	}
	
	/// After this call, you MUST set the constraints programmatically!
	func addAllSubviewsAndDisableAutoConstraints(_ subviews: UIView...) {
		for subview in subviews {
			addSubview(subview)
			subview.disableAutoConstraints()
		}
	}
	
	func pinToEdges(of superview: UIView) {
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: superview.topAnchor),
			leadingAnchor.constraint(equalTo: superview.leadingAnchor),
			trailingAnchor.constraint(equalTo: superview.trailingAnchor),
			bottomAnchor.constraint(equalTo: superview.bottomAnchor)
		])
	}
	
	/// Centers the view horizontally and vertically 
	func pinToCenter(of superview: UIView) {
		NSLayoutConstraint.activate([
			centerXAnchor.constraint(equalTo: superview.centerXAnchor),
			centerYAnchor.constraint(equalTo: superview.centerYAnchor)
		])
	}
	
	/// Constrains the view to its superview's top, leading, and trailing anchors with a padding (defaults to 0)
	func constrainToUpperHalf(of superview: UIView, padding: CGFloat = 0.0) {
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: superview.topAnchor, constant: padding),
			leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding),
			trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -(padding))
		])
	}
	
	/// Constrains the view to its superview's bottom, leading, and trailing anchors with a padding (defaults to 0)
	func constrainToLowerHalf(of superview: UIView, padding: CGFloat = 0.0) {
		NSLayoutConstraint.activate([
			bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -(padding)),
			leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding),
			trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -(padding))
		])
	}
	
	/// Constrains the view to its superview's leading and trailing anchors with a padding (defaults to 0)
	func constrainToLeadingAndTrailingAnchors(of superview: UIView, padding: CGFloat = 0.0) {
		NSLayoutConstraint.activate([
			leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding),
			trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -(padding))
		])
	}
	
	/// Constrains the height and width anchors with the same value, aka constrains it within a square
	func constrainSizeToConstant(_ constant: CGFloat) {
		NSLayoutConstraint.activate([
			heightAnchor.constraint(equalToConstant: constant),
			widthAnchor.constraint(equalToConstant: constant)
		])
	}
}

