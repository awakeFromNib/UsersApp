//
//  String + Extensions.swift
//  Users
//
//  Created by Sergei Anisimov on 10.06.2024.
//

import Foundation

extension String {
	func getFirstSymbols() -> String {
		self.split(separator: " ")
			.prefix(3)
			.reduce("", { $0 + String($1[$1.startIndex]) })
			.uppercased()
	}
}
