//
//  GlobalErrorHandler.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 14/06/25.
//

import UIKit

final class GlobalErrorHandler {
    static let shared = GlobalErrorHandler()
    private init() {}

    func showError(_ message: String) {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first?.windows
                .first(where: { $0.isKeyWindow }) else { return }

            if window.subviews.contains(where: { $0 is ToastView }) {
                return
            }

            let toast = ToastView(message: message)
            window.addSubview(toast)

            toast.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                toast.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 16),
                toast.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -16),
                toast.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor, constant: -64),
                toast.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
            ])

            toast.showAndDismiss()
        }
    }
}
