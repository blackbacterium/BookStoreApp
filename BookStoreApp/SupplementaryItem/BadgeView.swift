//
//  BadgeView.swift
//  BookStoreApp
//
//  Created by Black Bacterium on 19.11.2026.
//

import UIKit

class BadgeView: UICollectionReusableView {
	static let reuseIdentifier = "BadgeView"
	private let badgeLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configureBadge(text: String = "Новинка") {
		badgeLabel.text = text
	}
}

private extension BadgeView {
	func setupView() {
		badgeLabel.frame = bounds
		badgeLabel.backgroundColor = .systemPurple
		badgeLabel.textColor = .white
		badgeLabel.font = .systemFont(ofSize: 16, weight: .bold)
		badgeLabel.textAlignment = .center
		badgeLabel.layer.cornerRadius = 6
		badgeLabel.layer.masksToBounds = true
		addSubview(badgeLabel)
	}
}
