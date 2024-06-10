//
//  UserDetailsView.swift
//  Users
//
//  Created by Sergei Anisimov on 10.06.2024.
//

import UIKit

/// View for single user info
final class UserDetailsView: UIView {

	private let viewModel: UserDetailsViewModel

	private let nameLabel = UILabel()
	private let usernameLabel = UILabel()
	private let emailLabel = UILabel()
	//	let address = UILabel()
	private let phoneLabel = UILabel()
	private let streetLabel = UILabel()
	private let suiteLabel = UILabel()
	private let cityLabel = UILabel()

	private var labelStackView = UIStackView()

	private let spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .large)
		spinner.hidesWhenStopped = true
		spinner.translatesAutoresizingMaskIntoConstraints = false
		return spinner
	}()

	// MARK: - Init
	init(frame: CGRect, viewModel: UserDetailsViewModel) {
		self.viewModel = viewModel
		super.init(frame: frame)
		translatesAutoresizingMaskIntoConstraints = false
		addSubviews(labelStackView, spinner)

		displayUserInfo()
		setupViews()
		addConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("Unsupported")
	}

	private func setupViews() {
		backgroundColor = .systemBackground
		labelStackView = UIStackView(arrangedSubviews: [
			nameLabel, usernameLabel, emailLabel, phoneLabel, cityLabel, streetLabel, suiteLabel
		])
		labelStackView.axis = .vertical
		labelStackView.spacing = 2
		labelStackView.translatesAutoresizingMaskIntoConstraints = false

		addSubview(labelStackView)
	}

	private func displayUserInfo() {
		nameLabel.text = "Name: \(viewModel.name)"
		usernameLabel.text = "Username: \(viewModel.username)"
		emailLabel.text = "Email: \(viewModel.email)"
		phoneLabel.text = "Phone: \(viewModel.phone)"
		streetLabel.text = "Street: \(viewModel.street)"
		suiteLabel.text = "Suite: \(viewModel.suite)"
		cityLabel.text = "City: \(viewModel.city)"
	}

	private func addConstraints() {
		NSLayoutConstraint.activate([

			spinner.widthAnchor.constraint(equalToConstant: 100),
			spinner.heightAnchor.constraint(equalToConstant: 100),
			spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
			spinner.centerYAnchor.constraint(equalTo: centerYAnchor),

			labelStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			labelStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20)
		])
	}
}

