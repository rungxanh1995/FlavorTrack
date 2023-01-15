//
//  ViewController.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

class SearchVC: UIViewController {

	private let logoImageView: UIImageView = .init()
	private let addressTextField: FTTextField = .init(withPlaceholder: "Enter an address near you")
	private let businessTypeTextField: FTTextField = .init(withPlaceholder: "What are you craving? Vietnamese?")
	private let callToActionButton: FTButton = .init(withTitle: "Let's go!")
	
	private var _isAddressEntered: Bool { !addressTextField.text!.isEmpty }
	private var _isBusinessTypeEntered: Bool { !businessTypeTextField.text!.isEmpty }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		view.addAllSubviewsAndDisableAutoConstraints(logoImageView, addressTextField, businessTypeTextField, callToActionButton)
		configLogoImageView()
		configTextFields()
		configActionButton()
		configKeyboardHiding()
		configDismissKeyboardTapGesture()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
}

// MARK: - UI Configuration
private extension SearchVC {
	private func configLogoImageView() -> Void {
		logoImageView.image = AppImages.ftLogo
		
		NSLayoutConstraint.activate([
			logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
			logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			logoImageView.heightAnchor.constraint(equalToConstant: 200),
			logoImageView.widthAnchor.constraint(equalToConstant: 200)
		])
	}
	
	private func configTextFields() -> Void {
		NSLayoutConstraint.activate([
			addressTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
			addressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
			addressTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
			addressTextField.heightAnchor.constraint(equalToConstant: 44),
			
			businessTypeTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 24),
			businessTypeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
			businessTypeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
			businessTypeTextField.heightAnchor.constraint(equalToConstant: 44)
		])
		
		addressTextField.delegate = self
		businessTypeTextField.delegate = self
	}
	
	private func configActionButton() -> Void {
		NSLayoutConstraint.activate([
			callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
			callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
			callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
			callToActionButton.heightAnchor.constraint(equalToConstant: 44)
		])
		
//		callToActionButton.addTarget(self, action: #selector(_pushFollowerListVC), for: .touchUpInside)
	}
}

extension SearchVC: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		addressTextField.resignFirstResponder()
		businessTypeTextField.resignFirstResponder()
		return true
	}
}

// MARK: - Keyboard
private extension SearchVC {
	/// Add observers to the current active textfield,
	/// so that it wouldn't be hidden behind the keyboard
	private func configKeyboardHiding() -> Void {
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillShow),
			name: UIResponder.keyboardWillShowNotification,
			object: nil)
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillHide),
			name: UIResponder.keyboardWillHideNotification,
			object: nil)
	}
	
	private func configDismissKeyboardTapGesture() -> Void {
		let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
		view.addGestureRecognizer(tap)
	}
}
