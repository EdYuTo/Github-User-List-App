//
//  UserTableViewCell.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = "UserTableViewCell"
    var model: UserViewModel!
    
    // MARK: - Life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = UIImage()
    }
    
    // MARK: Methods
    func configure(_ model: UserViewModel) {
        self.model = model
        textLabel?.text = model.userName
        ImageProvider.getImage(url: model.avatarUrl) { uiImage in
            DispatchQueue.main.async { [weak self] in
                self?.imageView?.image = uiImage
                self?.layoutSubviews()
            }
        }
    }
}
