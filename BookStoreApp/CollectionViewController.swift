//
//  ViewController.swift
//  BookStoreApp
//
//  Created by Black Bacterium on 12.11.2026.
//

import UIKit

class CollectionViewController: UIViewController {
	private let reuseIdentifier = "reuseIdentifier"
	private var collectionView: UICollectionView!
	private var bookTypes: [BookType] = []
	
	private let bookTypeManager: IBookTypeManager = BookTypeManager()


	override func viewDidLoad() {
		super.viewDidLoad()
		
		bookTypes = bookTypeManager.getBookTypes()
		
		setupView()
		configureCollectionView()
	}
}


private extension CollectionViewController {
	func setupView() {
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
		
		collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		
		collectionView.register(
			SectionHeaderView.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: SectionHeaderView.reuseIdentifier
		)
		
		collectionView.register(
			BadgeView.self,
			forSupplementaryViewOfKind: ElementKind.badge,
			withReuseIdentifier: BadgeView.reuseIdentifier)
		
		collectionView.backgroundColor = .black
		collectionView.dataSource = self
		
		view.addSubview(collectionView)
	}
}

// MARK: - Settings Layout
private extension CollectionViewController {
	func createLayout() -> UICollectionViewLayout {
		
		let bookItem = createLayoutItem()
		let bookGroup = createLayoutGroup(subitems: [bookItem])
		
		let section = NSCollectionLayoutSection(group: bookGroup)
		section.orthogonalScrollingBehavior = .continuous
		section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10)
		section.boundarySupplementaryItems = [createHeader()]
		
		return UICollectionViewCompositionalLayout(section: section)
	}
	
	func createLayoutItem() -> NSCollectionLayoutItem {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .fractionalHeight(1.0)
		)
		
		let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [createBadge()])
		item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
		return item
	}
	
	func createLayoutGroup(subitems: [NSCollectionLayoutItem]) -> NSCollectionLayoutGroup {
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.72),
			heightDimension: .absolute(200)
		)
		
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: groupSize,
			subitems: subitems
		)
		return group
	}
	
	func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
		let headerSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .absolute(50)
		)
		let header = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: headerSize,
			elementKind: UICollectionView.elementKindSectionHeader,
			alignment: .top
		)
		return header
	}
	
	func createBadge() -> NSCollectionLayoutSupplementaryItem {
		let badgeSize = NSCollectionLayoutSize(
			widthDimension: .absolute(145),
			heightDimension: .absolute(30)
		)

		let constraints = NSCollectionLayoutAnchor(
			edges: [.top, .leading],
			absoluteOffset: CGPoint(x: 0, y: -30)
		)

		let badge = NSCollectionLayoutSupplementaryItem(
			layoutSize: badgeSize,
			elementKind: ElementKind.badge,
			containerAnchor: constraints
		)
		return badge
	}
	
	func configureCollectionView() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}

extension CollectionViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		bookTypes.count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		bookTypes[section].books.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: reuseIdentifier,
			for: indexPath
		) as? BookCollectionViewCell else { return UICollectionViewCell() }
		
		let book = bookTypes[indexPath.section].books[indexPath.item]
			cell.configure(with: book)
		
		return cell
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		viewForSupplementaryElementOfKind kind: String,
		at indexPath: IndexPath
	) -> UICollectionReusableView {
		
		if kind == UICollectionView.elementKindSectionHeader {
			let header = collectionView.dequeueReusableSupplementaryView(
				ofKind: kind,
				withReuseIdentifier: SectionHeaderView.reuseIdentifier,
				for: indexPath
			) as! SectionHeaderView
			header.configure(text: bookTypes[indexPath.section].type)
			return header
		} else if kind == ElementKind.badge {
			let badge = collectionView.dequeueReusableSupplementaryView(
				ofKind: kind,
				withReuseIdentifier: BadgeView.reuseIdentifier,
				for: indexPath
			) as! BadgeView
			let book = bookTypes[indexPath.section].books[indexPath.item]
			badge.configureBadge()
			badge.isHidden = !book.isNew
			return badge
		}
		
		return UICollectionReusableView()
	}
}
