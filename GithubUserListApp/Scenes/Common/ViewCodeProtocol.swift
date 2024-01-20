//
//  ViewCodeProtocol.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

protocol ViewCodeProtocol {
    func setupView()
    func setupHierarchy()
    func setupConstraints()
    func setupConfigurations()
}

extension ViewCodeProtocol {
    func setupView() {
        setupHierarchy()
        setupConstraints()
        setupConfigurations()
    }

    func setupConfigurations() {
        /* Optional */
    }
}
