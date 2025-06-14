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
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Popular Shows"
        return label
    }()
    
    private let showTalbeView: UITableView = {
        let tableView = UITableView()
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
        addSubview(titleLabel)
        addSubview(showTalbeView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),

            showTalbeView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
            showTalbeView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .background
    }
}
