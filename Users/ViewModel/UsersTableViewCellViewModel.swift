//
//  UsersTableViewCellViewModel.swift
//  Users
//
//  Created by Sergei Anisimov on 10.06.2024.
//

import Foundation

final class UsersTableViewCellViewModel: Hashable, Equatable {
	var name: String
	var email: String

	//	init(name: String, email: String) {
	//		self.name = name
	//		self.email = email
	//	}

	init(_ user: User) {
		self.name = user.name
		self.email = user.email
	}

	// MARK: - Hashable
	func hash(into hasher: inout Hasher) {
		hasher.combine(name)
		hasher.combine(email)
		//		hasher.combine(characterImageUrl)
	}

	static func == (lhs: UsersTableViewCellViewModel, rhs: UsersTableViewCellViewModel) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
}
