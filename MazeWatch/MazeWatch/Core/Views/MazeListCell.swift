//
//  MazeListCell.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 14/06/25.
//
import UIKit

class MazeListCell: UITableViewCell, ViewCode {
    
    func setupAdditionalConfiguration() {
        //
    }
    

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Image")
        return imageView
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .fill
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        backgroundColor = .clear
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildViewHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(cellImageView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 360),
            containerView.heightAnchor.constraint(equalToConstant: 120),

            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: cellImageView.leadingAnchor, constant: -24),

            cellImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            cellImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            cellImageView.widthAnchor.constraint(equalToConstant: 80),
            cellImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    func configure(imageURL: String, title: String) {
        self.titleLabel.text = title
        ImageLoader.shared.load(from: imageURL) { [weak self] image in
            self?.cellImageView.image = image
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    let cell = MazeListCell()
    cell.configure(imageURL: "", title: "The Witcher")
    return cell
}
