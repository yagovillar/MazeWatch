//
//  SeasonPickerViewController.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//
import UIKit

class SeasonPickerViewController: UIViewController {
    var seasons: [Season] = []
    var onSelect: ((Season) -> Void)?

    private let backgroundView = UIView()
    private let containerView = UIView()
    private let pickerView = UIPickerView()
    private let toolbar = UIToolbar()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupViews()
        setupConstraints()
        addTapToDismiss()
    }

    private func setupViews() {
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        view.addSubview(containerView)

        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissSelf))
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Select", style: .done, target: self, action: #selector(selectSeason))
        toolbar.setItems([cancel, flex, done], animated: false)

        containerView.addSubview(toolbar)
        containerView.addSubview(pickerView)

        pickerView.dataSource = self
        pickerView.delegate = self

        toolbar.translatesAutoresizingMaskIntoConstraints = false
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pickerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 200),

            containerView.heightAnchor.constraint(equalToConstant: 244), // picker + toolbar

            // Toolbar
            pickerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 44),
            toolbar.topAnchor.constraint(equalTo: containerView.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func addTapToDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissSelf() {
        dismiss(animated: true)
    }

    @objc private func selectSeason() {
        let selectedIndex = pickerView.selectedRow(inComponent: 0)
        if seasons.indices.contains(selectedIndex) {
            onSelect?(seasons[selectedIndex])
        }
        dismiss(animated: true)
    }
}

extension SeasonPickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        seasons.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "Season \(seasons[row].number ?? 0)"
    }
}
