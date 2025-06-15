//
//  MazeSearchBar.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 14/06/25.
//
import UIKit

class CustomSearchBar: UIView, ViewCode {

    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search…"
        textField.layer.cornerRadius = 8
        textField.leftView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        textField.leftViewMode = .always
        textField.rightView = UIButton(type: .system)
        textField.rightViewMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildViewHierarchy() {
        addSubview(textField)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .fill
        layer.cornerRadius = 16
        clipsToBounds = true

        textField.backgroundColor = .clear
        textField.textColor = .white

        textField.attributedPlaceholder = NSAttributedString(
            string: textField.placeholder ?? "",
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.7)]
        )

    }
}
