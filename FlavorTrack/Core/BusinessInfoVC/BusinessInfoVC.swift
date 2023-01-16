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

	private var scrollView: UIScrollView!
	private var contentView: UIView!
	
	private var headerView: UIView!
	private var detailView: UIView!
	private var mapView: FTMapView!
	
	init(for business: Business) {
		super.init(nibName: nil, bundle: nil)
		self.business = business
		self.scrollView = .init()
		self.contentView = .init()
		self.headerView = .init()
		self.detailView = .init()
		self.mapView = .init()
	}
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .systemBackground
		title = business.name
		
		layoutUIElements()
		configUIElements(for: business)
    }
}

private extension BusinessInfoVC {
	private func layoutUIElements() -> Void {
		view.addAllSubviewsAndDisableAutoConstraints(scrollView)
		scrollView.addAllSubviewsAndDisableAutoConstraints(contentView)
		contentView.addAllSubviewsAndDisableAutoConstraints(headerView, detailView, mapView)
		
		let _edgePadding: CGFloat = 12.0
		let _itemPadding: CGFloat = 24.0
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			
			contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
			contentView.heightAnchor.constraint(equalToConstant: 600),
			
			headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: _edgePadding),
			headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: _edgePadding),
			headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(_edgePadding)),
			headerView.heightAnchor.constraint(equalToConstant: 120),
			
			detailView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: _itemPadding),
			detailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: _edgePadding),
			detailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(_edgePadding)),
			detailView.heightAnchor.constraint(equalToConstant: 140),
			
			mapView.topAnchor.constraint(equalTo: detailView.bottomAnchor, constant: _itemPadding),
			mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: _edgePadding),
			mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(_edgePadding)),
			mapView.heightAnchor.constraint(equalToConstant: 280),
		])
		
		
		let doneBarBtn: UIBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: #selector(_dismissVC))
		navigationItem.setRightBarButtonItems([doneBarBtn], animated: true)
	}
	
	private func configUIElements(for business: Business) -> Void {
		addChildController(BusinessInfoHeaderVC(for: business), to: headerView)
		addChildController(BusinessInfoDetailVC(for: business), to: detailView)
		addChildController(BusinessInfoMapVC(for: business), to: mapView)
	}
	
	@objc
	private func _dismissVC() { dismiss(animated: true) }
}
