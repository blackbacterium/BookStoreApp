//
//  BookCollectionViewCell.swift
//  BookStoreApp
//
//  Created by Black Bacterium on 19.11.2026.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {

	private let bookImage = UIImageView()
	private let titleLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
		setupLayout()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(with book: Book) {
		bookImage.image = UIImage(named: book.image)
		titleLabel.text = book.title
	}
}

private extension BookCollectionViewCell {
	func setupViews() {
		contentView.addSubview(bookImage)
		contentView.addSubview(titleLabel)

		bookImage.contentMode = .scaleAspectFill
		bookImage.clipsToBounds = true
		bookImage.layer.cornerRadius = 8

		titleLabel.textAlignment = .left
		titleLabel.textColor = .white
		titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
	}

	func setupLayout() {
		bookImage.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			bookImage.topAnchor.constraint(equalTo: contentView.topAnchor),
			bookImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			bookImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			bookImage.heightAnchor.constraint(equalToConstant: 140),

			titleLabel.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 8),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}
