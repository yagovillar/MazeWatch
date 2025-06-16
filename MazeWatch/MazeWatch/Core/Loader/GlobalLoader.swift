//
//  GlobalLoader.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 14/06/25.
//
import UIKit

final class GlobalLoader {
    static let shared = GlobalLoader()

    private var backgroundView: UIView?
    private var activityIndicator: UIActivityIndicatorView?

    private init() {}

    func show() {
        guard backgroundView == nil,
              let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }

        let overlay = UIView(frame: window.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.4)

        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .white
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()

        overlay.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: overlay.centerYAnchor)
        ])

        window.addSubview(overlay)

        self.backgroundView = overlay
        self.activityIndicator = spinner
    }

    func hide() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
            self.backgroundView?.removeFromSuperview()
            self.activityIndicator = nil
            self.backgroundView = nil
        }
    }
}
