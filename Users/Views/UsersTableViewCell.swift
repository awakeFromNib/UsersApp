//
//  UsersTableViewCell.swift
//  Users
//
//  Created by Sergei Anisimov on 10.06.2024.
//

import UIKit

final class UsersTableViewCell: UITableViewCell {
	static var identifier: String {
		"UsersTableViewCell"
	}

	private let avatarLabel: UILabel = {
		let label = UILabel()
		label.backgroundColor = .systemGray3
		label.textAlignment = .center
		label.clipsToBounds = true
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private let nameLabel = UILabel()
	private let emailLabel = UILabel()
	private var labelStackView = UIStackView()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - avatar edition method
	override func layoutSubviews() {
		super.layoutSubviews()
		avatarLabel.layer.cornerRadius = avatarLabel.frame.width / 2
	}

	private func setupViews() {
		nameLabel.font = .systemFont(ofSize: 16)
		emailLabel.font = .systemFont(ofSize: 14)
		emailLabel.textColor = .gray

		labelStackView = UIStackView(arrangedSubviews: [nameLabel, emailLabel])
		labelStackView.axis = .vertical
		labelStackView.spacing = 2
		labelStackView.translatesAutoresizingMaskIntoConstraints = false

		addSubviews(avatarLabel, labelStackView)

		NSLayoutConstraint.activate([
			avatarLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			avatarLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
			avatarLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
			avatarLabel.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),

			labelStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
			// labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
			labelStackView.leadingAnchor.constraint(equalTo: avatarLabel.trailingAnchor, constant: 10),
			// MARK: - avatar edition constraint
			labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
		])
	}

	func configure(with viewModel: UsersTableViewCellViewModel) {
		avatarLabel.text = viewModel.name.getFirstSymbols()
		nameLabel.text = viewModel.name
		emailLabel.text = viewModel.email
	}
}
