//
//  LoadableScreen.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

/// Allows any conformed view controller to show or dismiss spinning indicator when loading data.
/// For example, when downloading data over internet.
protocol LoadableScreen: AnyObject {
	var containerView: UIView! { get set }
	func showLoadingOverlay()
	func dismissLoadingOverlay()
}

extension LoadableScreen where Self: UIViewController {
	func showLoadingOverlay() {
		containerView = .init(frame: view.bounds)
		view.addSubview(containerView)
		containerView.backgroundColor = .systemBackground
		containerView.alpha = 0.0
		UIView.animate(withDuration: 0.25) { [weak self] in
			self?.containerView.alpha = 0.8
		}

		let indicatorOverlay: UIActivityIndicatorView = .init(style: .large)
		containerView.addSubview(indicatorOverlay)
		indicatorOverlay.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			indicatorOverlay.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
			indicatorOverlay.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
		])
		indicatorOverlay.startAnimating()
	}

	func dismissLoadingOverlay() {
		DispatchQueue.main.async { [weak self] in
			self?.containerView.removeFromSuperview()
			self?.containerView = nil
		}
	}
}
