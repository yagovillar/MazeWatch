import UIKit

class ToastView: UIView {

    private let iconImageView = UIImageView()
    private let messageLabel = UILabel()
    private let stackView = UIStackView()

    private let message: String
    private let icon: UIImage?

    init(message: String, icon: UIImage? = UIImage(systemName: "exclamationmark.triangle.fill")) {
        self.message = message
        self.icon = icon
        super.init(frame: .zero)
        setupView()
        alpha = 0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ToastView: ViewCode {
    func buildViewHierarchy() {
        iconImageView.image = icon
        iconImageView.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        messageLabel.textAlignment = .left

        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(messageLabel)

        addSubview(stackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),

            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    func setupAdditionalConfiguration() {
        backgroundColor = .accent
        layer.cornerRadius = 12
        clipsToBounds = true
    }
}

extension ToastView {
    func showAndDismiss(duration: TimeInterval = 3.0, fadeDuration: TimeInterval = 0.3) {
        layer.removeAllAnimations()

        self.alpha = 0
        self.isHidden = false

        UIView.animate(withDuration: fadeDuration, animations: {
            self.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: fadeDuration, delay: duration, options: [], animations: {
                self.alpha = 0
            }, completion: { _ in
                self.removeFromSuperview()
            })
        })
    }
}
