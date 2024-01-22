//
//  UIViewController+extensions.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 21/01/24.
//

import UIKit

extension UIViewController {
    func dequeueLoadingCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: LoadingTableViewCell.reuseIdentifier,
            for: indexPath
        )
        cell.selectionStyle = .none
        return cell
    }

    func dequeueErrorCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(
            withIdentifier: ErrorTableViewCell.reuseIdentifier,
            for: indexPath
        )
    }
}
