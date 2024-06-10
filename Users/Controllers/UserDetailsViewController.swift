//
//  UserDetailsViewController.swift
//  Users
//
//  Created by Sergei Anisimov on 10.06.2024.
//

import UIKit

class UserDetailsViewController: UIViewController {

	private let viewModel: UserDetailsViewModel

	private let detailView: UserDetailsView

	init(viewModel: UserDetailsViewModel) {
		self.viewModel = viewModel
		self.detailView = UserDetailsView(frame: .zero, viewModel: viewModel)
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		title = viewModel.name
		view.addSubview(detailView)
		addConstraints()
	}
	private func addConstraints() {
		NSLayoutConstraint.activate([
			detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
			detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}
