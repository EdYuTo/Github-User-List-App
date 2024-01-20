//
//  ImageProvider.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

import UIKit

final class ImageProvider {
    private static let provider = NertworkProvider()

    func getImage(url: String, _ completion: @escaping (UIImage) -> Void) {
        let request = NetworkRequest(endpoint: url)
        Self.provider.makeRequest(request) { (result: Result<Data, Error>) in
            if case let .success(data) = result,
               let image = UIImage(data: data) {
                return completion(image)
            }
            completion(UIImage())
        }
    }
}
