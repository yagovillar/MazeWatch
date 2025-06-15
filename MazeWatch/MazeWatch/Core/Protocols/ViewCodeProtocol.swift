//
//  ViewCodeProtocol.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//

protocol ViewCode {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension ViewCode {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
