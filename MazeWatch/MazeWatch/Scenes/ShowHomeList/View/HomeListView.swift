//
//  HomeListView.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//
import UIKit

final class HomeListView: UIView {

    // MARK: - UI Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Popular Shows"
        return label
    }()
    
    let showTalbeView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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

extension HomeListView: ViewCode {
    func buildViewHierarchy() {
        addSubview(showTalbeView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            showTalbeView.topAnchor.constraint(equalTo: topAnchor, constant: 28),
            showTalbeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            showTalbeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            showTalbeView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .background
        showTalbeView.tableHeaderView = titleLabel

    }
}

#Preview {
    HomeListView()
}
