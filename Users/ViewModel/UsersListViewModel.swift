//
//  UsersListViewModel.swift
//  Users
//
//  Created by Sergei Anisimov on 10.06.2024.
//

import UIKit

protocol UsersListViewViewModelDelegate: AnyObject {
	func didLoadAllUsers()
	func didSelectUser(_ user: User)
}

final class UsersListViewModel: NSObject {

	public weak var delegate: UsersListViewViewModelDelegate?

	private var isLoadingUsers = false

	var searching = false

	private var allUsers: [User] = [] {
		didSet {
			for user in allUsers {
				let viewModel = UsersTableViewCellViewModel(user)
				if !cellViewModels.contains(viewModel) {
					cellViewModels.append(viewModel)
				}
			}
		}
	}

	private(set) var filteredUsers: [User] = []

	private var cellViewModels: [UsersTableViewCellViewModel] = []

	func numberOfSections() -> Int {
		1
	}

	func numberOfRows(_ section: Int) -> Int {
		allUsers.count
	}

	public func getUsers() {
		NetworkDataFetch.shared.fetchUsers { [weak self] users, error in
			guard let self else { return }
			self.isLoadingUsers = false
			if let users {
				self.allUsers = users
				DispatchQueue.main.async {
					self.delegate?.didLoadAllUsers()
				}
			}
		}
	}
}

extension UsersListViewModel: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		cellViewModels.count

	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: UsersTableViewCell.identifier,
			for: indexPath) as? UsersTableViewCell else {
			return UITableViewCell()
		}

		cell.configure(with: cellViewModels[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		60
	}

	// MARK: - Function where transition calls
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let user = allUsers[indexPath.row]

		delegate?.didSelectUser(user)
	}
}

// MARK: - Search Functions
extension UsersListViewModel {
	public func inSearchMode(_ searchController: UISearchController) -> Bool {
		let isActive = searchController.isActive
		let searchText = searchController.searchBar.text ?? ""
		return isActive && !searchText.isEmpty
	}

	public func updateSearchController(searchBarText: String?) {
		self.filteredUsers = allUsers

		if let searchText = searchBarText?.lowercased() {
			guard !searchText.isEmpty else { self.getUsers(); return }

			self.filteredUsers = self.filteredUsers.filter({ $0.name.lowercased().contains(searchText)})
		}
		self.getUsers()  //???
	}
}
