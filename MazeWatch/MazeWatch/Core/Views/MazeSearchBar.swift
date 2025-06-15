//
//  MazeSearchBar.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 14/06/25.
//
import Foundation
import UIKit

class CustomSearchBar: UIView, ViewCode {

    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search…"
        textField.layer.cornerRadius = 8
        textField.leftView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        textField.leftViewMode = .always
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) { fatalError() }

    func buildViewHierarchy() {
        addSubview(textField)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .fill
        self.clipsToBounds = true
        self.layer.cornerRadius = 16

        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: textField.placeholder ?? "",
            attributes: [.foregroundColor: UIColor.white]
        )
        textField.rightView = UIButton(type: .system)
        (textField.rightView as? UIButton)?.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        textField.rightViewMode = .whileEditing

    }
}

#Preview {
    CustomSearchBar()
}
