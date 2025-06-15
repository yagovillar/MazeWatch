//
//  EpisodesListCell.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 14/06/25.
//

import UIKit

class EpisodesListCell: UITableViewCell, ViewCode {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Title"
        return label
    }()

    private let seasonAndEpisodeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "Season 1 - Episode 1"
        return label
    }()

    private let backGroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.opacity = 0.4
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        super.setNeedsLayout()
        super.layoutIfNeeded()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func buildViewHierarchy() {
        contentView.addSubview(backGroundImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(seasonAndEpisodeLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 80),
            self.widthAnchor.constraint(equalToConstant: 338),

            self.backGroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.backGroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            self.backGroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.backGroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),

            self.seasonAndEpisodeLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4),
            self.seasonAndEpisodeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
    }

    func setupAdditionalConfiguration() {
        self.backGroundImageView.image = UIImage(named: "Image")
        self.backGroundImageView.clipsToBounds = true
        self.backGroundImageView.layer.cornerRadius = 16
        self.backgroundColor = .fill
        self.layer.cornerRadius = 16

    }
}

extension EpisodesListCell {
    func configure(title: String, season: Int, episode: Int, imageURL: String) {
        self.titleLabel.text = title
        ImageLoader.shared.load(from: imageURL) { [weak self] image in
            self?.backGroundImageView.image = image
        }
        self.seasonAndEpisodeLabel.text = "Season \(season) - Episode \(episode)"
    }
}

#Preview {
    EpisodesListCell()
}
