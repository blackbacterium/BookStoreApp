//
//  Needfull types.swift
//  BookStoreApp
//
//  Created by Black Bacterium on 19.11.2026.
//

import Foundation

struct ElementKind {
	static let badge = "badge-element-kind"
}

struct BookType {
	let type: String
	let books: [Book]
}

struct Book {
	let image: String
	let title: String
	var isNew = false
}
