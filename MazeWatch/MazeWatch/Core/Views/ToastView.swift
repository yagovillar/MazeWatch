//
//  ToastView.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 14/06/25.
//

import UIKit

class ToastView: UIView {

    private let messageLabel = UILabel()

    init(message: String) {
        super.init(frame: .zero)
        backgroundColor = UIColor.red.withAlphaComponent(0.9)
        layer.cornerRadius = 12
        clipsToBounds = true

        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        messageLabel.textAlignment = .center

        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
        
        alpha = 0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showAndDismiss() {
        // Fade in
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        }) { _ in
            // Depois some depois de 3 segundos
            UIView.animate(withDuration: 0.3, delay: 3, options: [], animations: {
                self.alpha = 0
            }) { _ in
                self.removeFromSuperview()
            }
        }
    }
}
