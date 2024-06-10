//
//  UsersListView.swift
//  Users
//
//  Created by Sergei Anisimov on 10.06.2024.
//

import UIKit

protocol UsersListViewDelegate: AnyObject {
	func allUsersListView(_ usersListView: UsersListView, didSelectUser user: User)
}

final class UsersListView: UIView {

	public weak var delegate: UsersListViewDelegate?
	public let viewModel = UsersListViewModel()

	// MARK: - UI Components
	private let spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .large)
		spinner.hidesWhenStopped = true
		spinner.translatesAutoresizingMaskIntoConstraints = false
		return spinner
	}()

	private lazy var usersTableView: UITableView = {
		let table = UITableView()
		table.alpha = 0
		table.isHidden = true
		table.backgroundColor = .systemBackground
		table.translatesAutoresizingMaskIntoConstraints = false
		table.register(UsersTableViewCell.self, forCellReuseIdentifier: UsersTableViewCell.identifier)
		return table
	}()

	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = .clear
		addSubviews(usersTableView, spinner)
		addConstraints()
		spinner.startAnimating()
		viewModel.delegate = self
		viewModel.getUsers()
		setUpTableView()
	}

	required init?(coder: NSCoder) {
		fatalError("Unsupported")
	}

	private func addConstraints() {
		NSLayoutConstraint.activate([
			spinner.widthAnchor.constraint(equalToConstant: 100),
			spinner.heightAnchor.constraint(equalToConstant: 100),
			spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
			spinner.centerYAnchor.constraint(equalTo: centerYAnchor),

			usersTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			usersTableView.leftAnchor.constraint(equalTo: leftAnchor),
			usersTableView.rightAnchor.constraint(equalTo: rightAnchor),
			usersTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}

	private func setUpTableView() {
		usersTableView.dataSource = viewModel
		usersTableView.delegate = viewModel
	}
}

extension UsersListView: UsersListViewViewModelDelegate {

	func didSelectUser(_ user: User) {
		delegate?.allUsersListView(self, didSelectUser: user)
	}

	func didLoadAllUsers() {
		spinner.stopAnimating()
		usersTableView.isHidden = false
		usersTableView.reloadData()
		UIView.animate(withDuration: 0.4, delay: 0, options: .layoutSubviews) {
			self.usersTableView.alpha = 1
		}
	}
}
