//
//  User.swift
//  Users
//
//  Created by Sergei Anisimov on 10.06.2024.
//

import Foundation

struct User: Codable {
	let name: String
	let username: String
	let email: String
	let address: Address
	let phone: String
}

struct Address: Codable {
	let street: String
	let suite: String
	let city: String
}
