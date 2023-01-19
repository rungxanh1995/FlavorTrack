//
//  FTAlert.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

final class FTAlert: UIViewController {
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private let containerView: FTAlertContainerView = .init()
	private let titleLabel: FTPrimaryTitleLabel = .init(textAlignment: .center, ofSize: 20)
	private let messageLabel: FTBodyLabel = .init(textAlignment: .center)
	private let alertButton: FTButton = .init(withTitle: "OK", color: UIColor.theme.accent)
	
	private var titleString: String?
	private var messageString: String?
	private var buttonTitleString: String?
	
	private let edgePadding: CGFloat = 16.0
	
	init(title: String, message: String, btnTitle: String) {
		super.init(nibName: nil, bundle: nil)
		self.titleString = title
		self.messageString = message
		self.buttonTitleString = btnTitle
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .black.withAlphaComponent(0.75)
		
		configContainerView()
		configTitleLabel()
		configAlertButton()
		configMessageLabel()
    }
    
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		
		/// Fixes border not updating its color when switching light/dark mode
		if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
			containerView.layer.borderColor = UIColor.systemGray4.cgColor
		}
	}
}

// MARK: - UI Configuration
private extension FTAlert {
	private func configContainerView() -> Void {
		view.addSubview(containerView)
		containerView.pinToCenter(of: view)
		
		NSLayoutConstraint.activate([
			containerView.widthAnchor.constraint(equalToConstant: 320),
			containerView.heightAnchor.constraint(equalToConstant: 240)
		])
	}
	
	private func configTitleLabel() -> Void {
		containerView.addSubview(titleLabel)
		titleLabel.text = NSLocalizedString(titleString ?? "Something went wrong", comment: "The text of the alert title")
		
		titleLabel.constrainToUpperHalf(of: containerView, padding: edgePadding)
		NSLayoutConstraint.activate([titleLabel.heightAnchor.constraint(equalToConstant: 28)])
	}
	
	private func configAlertButton() -> Void {
		containerView.addSubview(alertButton)
		alertButton.setTitle(NSLocalizedString(buttonTitleString ?? "OK", comment: "The text of the alert button title"), for: .normal)
		alertButton.addTarget(self, action: #selector(_dismissAlert), for: .touchUpInside)
		
		alertButton.constrainToLowerHalf(of: containerView, padding: edgePadding)
		NSLayoutConstraint.activate([alertButton.heightAnchor.constraint(equalToConstant: 48)])
	}
	
	@objc
	private func _dismissAlert() -> Void { dismiss(animated: true) }
	
	/// Message would fill up the space between title and action button,
	/// so please call it after you have already configured the other 2 views
	private func configMessageLabel() -> Void {
		containerView.addSubview(messageLabel)
		messageLabel.text = NSLocalizedString(messageString ?? "Unable to complete request", comment: "The text of the alert message")
		messageLabel.numberOfLines = 4
		
		messageLabel.constrainToLeadingAndTrailingAnchors(of: containerView, padding: edgePadding)
		// extra constraints
		NSLayoutConstraint.activate([
			messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			messageLabel.bottomAnchor.constraint(equalTo: alertButton.topAnchor, constant: -(8))
		])
	}
}
