//
//  UIView + Extensions.swift
//  Users
//
//  Created by Sergei Anisimov on 10.06.2024.
//

import UIKit

extension UIView {
	func addSubviews(_ views: UIView...) {
		views.forEach({
			addSubview($0)
		})
	}
}
