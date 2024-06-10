//
//  ViewController.swift
//  Users
//
//  Created by Sergei Anisimov on 10.06.2024.
//

import UIKit

final class UsersListViewController: UIViewController, UsersListViewDelegate {

	private let usersListView = UsersListView()

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Users"
		setupNavigationBar()
		setUpView()
	}

	// MARK: - Setup Navigation Bar
	public func setupNavigationBar() {
		title = "Users"
		navigationController?.navigationBar.prefersLargeTitles = false
		let navBarAppearance = UINavigationBarAppearance()
		navBarAppearance.backgroundColor = .systemBackground
		navigationController?.navigationBar.standardAppearance = navBarAppearance
		navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
	}

	private func setUpView() {
		view.backgroundColor = .systemBackground
		usersListView.delegate = self
		view.addSubview(usersListView)
		NSLayoutConstraint.activate([
			usersListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			usersListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			usersListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
			usersListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}

	// MARK: - UsersListViewDelegate
	func allUsersListView(_ usersListView: UsersListView, didSelectUser user: User) {
		let viewModel = UserDetailsViewModel(user: user)
		let detailVC = UserDetailsViewController(viewModel: viewModel)
		detailVC.navigationItem.largeTitleDisplayMode = .never
		navigationController?.pushViewController(detailVC, animated: true)
	}
}


