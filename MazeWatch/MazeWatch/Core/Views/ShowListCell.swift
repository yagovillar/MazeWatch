//
//  ShowListCell.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 14/06/25.
//
import UIKit
import SwiftUI

class ShowListCell: UITableViewCell, ViewCode {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.setImage(UIImage(systemName: "star.fill"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    init(image: UIImage, title: String, isFavorite: Bool = false, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
        configure(image: image, title: title, isFavorite: isFavorite)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func buildViewHierarchy() {
        self.contentView.addSubview(cellImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(favoriteButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -9),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.widthAnchor.constraint(equalToConstant: 122),
            
            favoriteButton.topAnchor.constraint(equalTo: self.cellImageView.topAnchor, constant: 18),
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            favoriteButton.heightAnchor.constraint(equalToConstant: 20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 20),
            
            self.heightAnchor.constraint(equalToConstant: 260),
            self.widthAnchor.constraint(equalToConstant: 160)
            ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .fill
        self.layer.cornerRadius = 20
        
        cellImageView.layer.cornerRadius = 20
        cellImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left & top right
        cellImageView.clipsToBounds = true
    }
    
}

extension ShowListCell {
    func configure(image: UIImage, title: String, isFavorite: Bool) {
        self.cellImageView.image = image
        self.titleLabel.text = title
        self.favoriteButton.isSelected = isFavorite
    }
}

@available(iOS 17, *)
#Preview {
    return ShowListCell()
}
