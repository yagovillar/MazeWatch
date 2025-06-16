//
//  ShowOrEpisodeDetailView.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//

import UIKit
import SwiftUI
import Foundation

final class ShowOrEpisodeDetailView: UIView {
    
    var onSeasonButtonTap: (() -> Void)?

    // MARK: - Background Components

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let darkOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - UI Components

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .white
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()

    let genresStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()

    let summaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    let seasonButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Season 1", for: .normal)
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let episodeTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let pickerView = UIPickerView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Configuration

    func configureForShow(_ show: ShowDetails) {
        DispatchQueue.main.async {
            self.titleLabel.text = show.name
            self.subtitleLabel.text = show.schedule.days.joined(separator: ", ") + (show.schedule.time.isEmpty ? " " : "\(show.schedule.time)")

            self.genresStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
            for genre in show.genres {
                let label = UILabel()
                label.text = genre
                label.font = .systemFont(ofSize: 12, weight: .medium)
                label.textColor = .white
                label.backgroundColor = UIColor(white: 1, alpha: 0.1)
                label.layer.cornerRadius = 8
                label.clipsToBounds = true
                label.textAlignment = .center
                self.genresStack.addArrangedSubview(label)
            }

            self.summaryLabel.text = show.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
            self.seasonButton.isHidden = false
            self.episodeTableView.isHidden = false
            self.setBackgroundImage(show.image?.medium ?? "")
            self.setupEpisodeTableViewConstraints()
        }
    }

    func configureForEpisode(_ episode: Episode, show: ShowDetails) {
        DispatchQueue.main.async {
            self.titleLabel.text = show.name
            self.subtitleLabel.text = "Season \(episode.season ?? 0) x Episode \(episode.number ?? 0)"
            self.genresStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
            self.summaryLabel.text = episode.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
            self.seasonButton.isHidden = true
            self.episodeTableView.isHidden = true
            self.setBackgroundImage(episode.image?.medium ?? "")
        }
    }

    func setBackgroundImage(_ imageURL: String) {
        ImageLoader.shared.load(from: imageURL) { [weak self] image in
            self?.backgroundImageView.image = image
        }
    }
}

// MARK: - ViewCode

extension ShowOrEpisodeDetailView: ViewCode {
    func buildViewHierarchy() {
        addSubview(backgroundImageView)
        addSubview(darkOverlayView)

        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(genresStack)
        addSubview(summaryLabel)
        addSubview(seasonButton)
        addSubview(episodeTableView)
    }

    func setupConstraints() {
        setupBackgroundConstraints()
        setupTitleLabelConstraints()
        setupSubtitleLabelConstraints()
        setupGenresStackConstraints()
        setupSummaryLabelConstraints()
        setupSeasonButtonConstraints()
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .black
        seasonButton.addTarget(self, action: #selector(seasonButtonTapped), for: .touchUpInside)
    }
    
    @objc private func seasonButtonTapped() {
        onSeasonButtonTap?()
    }
}

// MARK: - Constraints Helpers

private extension ShowOrEpisodeDetailView {

    func setupBackgroundConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            darkOverlayView.topAnchor.constraint(equalTo: topAnchor),
            darkOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            darkOverlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            darkOverlayView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setupTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }

    func setupSubtitleLabelConstraints() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }

    func setupGenresStackConstraints() {
        genresStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genresStack.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            genresStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            genresStack.trailingAnchor.constraint(lessThanOrEqualTo: titleLabel.trailingAnchor)
        ])
    }

    func setupSummaryLabelConstraints() {
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: genresStack.bottomAnchor, constant: 16),
            summaryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }

    func setupSeasonButtonConstraints() {
        seasonButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seasonButton.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 24),
            seasonButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            seasonButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            seasonButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func setupEpisodeTableViewConstraints() {
        episodeTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            episodeTableView.topAnchor.constraint(equalTo: seasonButton.bottomAnchor, constant: 16),
            episodeTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            episodeTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            episodeTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
