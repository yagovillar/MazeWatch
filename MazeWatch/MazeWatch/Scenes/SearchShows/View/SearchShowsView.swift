//
//  SearchShowsView.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 14/06/25.
//
import UIKit

final class SearchShowsView: UIView {

    // MARK: - UI Components

    let searchBar: CustomSearchBar = {
        let searchBar = CustomSearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    let showTalbeView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: - ViewCode Conformance

extension SearchShowsView: ViewCode {
    func buildViewHierarchy() {
        addSubview(searchBar)
        addSubview(showTalbeView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),

            showTalbeView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 28),
            showTalbeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            showTalbeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            showTalbeView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .background
    }
}

#Preview {
    SearchShowsView()
}
