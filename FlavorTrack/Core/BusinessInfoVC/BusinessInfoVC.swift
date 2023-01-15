//
//  BusinessInfoVC.swift
//  FlavorTrack
//
//  Created by Joe Pham on 2023-01-15.
//

import UIKit

class BusinessInfoVC: UIViewController, LoadableScreen {

	internal var containerView: UIView!
	private var business: Business!
	
	
	init(for business: Business) {
		super.init(nibName: nil, bundle: nil)
		self.business = business
	}
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .systemBackground
		title = business.name
		
		layoutUIElements()
    }
}

private extension BusinessInfoVC {
	private func layoutUIElements() -> Void {
		let doneBarBtn: UIBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: #selector(_dismissVC))
		navigationItem.setRightBarButtonItems([doneBarBtn], animated: true)
	}
	
	@objc
	private func _dismissVC() { dismiss(animated: true) }
}
