//
//  FTAlert.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

class FTAlert: UIViewController {
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private let containerView: FTAlertContainerView = .init()
	private let titleLabel: FTPrimaryTitleLabel = .init(textAlignment: .center, ofSize: 20)
	private let messageLabel: FTBodyLabel = .init(textAlignment: .center)
	private let alertButton: FTButton = .init(withTitle: "OK", color: UIColor.theme.accent)
	
	private var titleString: String?
	private var messageString: String?
	private var buttonTitleString: String?
	
	private let _padding: CGFloat = 20.0
	
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
		
		NSLayoutConstraint.activate([
			containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			containerView.widthAnchor.constraint(equalToConstant: 280),
			containerView.heightAnchor.constraint(equalToConstant: 220)
		])
	}
	
	private func configTitleLabel() -> Void {
		containerView.addSubview(titleLabel)
		titleLabel.text = titleString ?? "Something went wrong"
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: _padding),
			titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: _padding),
			titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -(_padding)),
			titleLabel.heightAnchor.constraint(equalToConstant: 28)
		])
	}
	
	private func configAlertButton() -> Void {
		containerView.addSubview(alertButton)
		alertButton.setTitle(buttonTitleString ?? "OK", for: .normal)
		alertButton.addTarget(self, action: #selector(_dismissAlert), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			alertButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -(_padding)),
			alertButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: _padding),
			alertButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -(_padding)),
			alertButton.heightAnchor.constraint(equalToConstant: 48)
		])
	}
	
	@objc
	private func _dismissAlert() -> Void { dismiss(animated: true) }
	
	/// Message would fill up the space between title and action button,
	/// so please call it after you have already configured the other 2 views
	private func configMessageLabel() -> Void {
		containerView.addSubview(messageLabel)
		messageLabel.text = messageString ?? "Unable to complete request"
		messageLabel.numberOfLines = 4
		
		NSLayoutConstraint.activate([
			messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: _padding),
			messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -(_padding)),
			messageLabel.bottomAnchor.constraint(equalTo: alertButton.topAnchor, constant: -(8))
		])
	}
}
