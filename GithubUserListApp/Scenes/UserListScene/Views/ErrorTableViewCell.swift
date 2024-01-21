//
//  ErrorTableViewCell.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

import UIKit

final class ErrorTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = "ErrorTableViewCell"
    
    // MARK: - Views
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("retry", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Methods
    func setup() {
        setupView()
    }
}

// MARK: - ViewCodeProtocol
extension ErrorTableViewCell: ViewCodeProtocol {
    func setupHierarchy() {
        addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
