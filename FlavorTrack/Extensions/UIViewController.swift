//
//  UIViewController.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-14.
//

import UIKit

// MARK: - Keyboard
extension UIViewController {

	@objc func keyboardWillShow(sender notification: NSNotification) {
		guard let userInfo = notification.userInfo,
			  let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
			  let currentTextField = UIResponder.currentFirst() as? UITextField else { return }

		// check if the top of the keyboard is above the bottom of the currently focused textbox
		let keyboardTopY = keyboardFrame.cgRectValue.origin.y
		let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
		let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

		// if textField bottom is below keyboard bottom - bump the frame up
		if textFieldBottomY > keyboardTopY {
			let textBoxY = convertedTextFieldFrame.origin.y
			let newFrameY = (textBoxY - keyboardTopY / 2) * -1
			view.frame.origin.y = newFrameY
		}
	}

	@objc func keyboardWillHide(sender notification: NSNotification) {
		view.frame.origin.y = 0
	}
}

extension UIViewController {
	/// Presents custom alert on main thread
	func presentAlert(
		title: String = "Something bad happened",
		message: String,
		buttonTitle: String = "OK") {

		DispatchQueue.main.async { [weak self] in
			let alert: FTAlert = .init(title: title, message: message, btnTitle: buttonTitle)
			alert.modalPresentationStyle = .overFullScreen
			alert.modalTransitionStyle = .crossDissolve
			self?.present(alert, animated: true)
		}
	}

	func presentDefaultAlert() {
		presentAlert(message: BusinessDataService.NetworkError.unableToComplete.rawValue)
	}

	func showEmptyStateView(saying message: String, in view: UIView) {
		let emptyStateView: GHEmptyStateView = .init(message: message)
		emptyStateView.frame = view.bounds
		view.addSubview(emptyStateView)
	}

	/// Place a child view controller into a custom view that this view controller manages
	func addChildController(_ childController: UIViewController, to containerView: UIView) {
		addChild(childController)
		containerView.addSubview(childController.view)
		childController.view.frame = containerView.bounds
	}
}
