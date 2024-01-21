//
//  Localizable.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

import Foundation

/*
    For xcode 15+ consider using string catalog:
    https://developer.apple.com/videos/play/wwdc2023/10155/
    https://developer.apple.com/documentation/xcode/localizing-and-varying-text-with-a-string-catalog
*/
enum Localizable: String {
    case retryButtonTitle
    case errorAlertTitle

    var localized: String {
        NSLocalizedString(rawValue, comment: String())
    }
}
