//
//  SectionHeaderView.swift
//  BookStoreApp
//
//  Created by Black Bacterium on 19.11.2026.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
	static let reuseIdentifier = "SectionHeaderView"
	private let label = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		label.frame = bounds
		label.textAlignment = .left
		label.font = UIFont.boldSystemFont(ofSize: 24)
		label.textColor = .white
		addSubview(label)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(text: String) {
		label.text = text
	}
}
