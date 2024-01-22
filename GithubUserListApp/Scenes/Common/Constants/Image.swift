//
//  Image.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 21/01/24.
//

import UIKit

enum Image: String {
    case person = "Person"
    case star = "Star"
    case laptop = "Laptop"

    var bundle: Bundle {
        Bundle(for: BundleHolder.self)
    }

    var value: UIImage? {
        UIImage(named: rawValue, in: bundle, compatibleWith: nil)
    }
}

extension Image {
    class BundleHolder {}
}
