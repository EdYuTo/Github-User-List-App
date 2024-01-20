//
//  NertworkProvider.swift
//  GithubUserListApp
//
//  Created by Edson Yudi Toma on 20/01/24.
//

import Foundation

protocol NertworkProviderProcotol {
    typealias Completion<T: Decodable, E: Error> = ((Result<T, E>) -> Void)

    func makeRequest(_ request: NetworkRequest, completion: @escaping Completion<Data, Error>)
    func makeRequest<T>(_ request: NetworkRequest, completion: @escaping Completion<T, Error>)
}

final class NertworkProvider: NertworkProviderProcotol {
    func makeRequest(_ request: NetworkRequest, completion: @escaping Completion<Data, Error>) {
        do {
            let urlRequest = try makeRequest(with: request)
            let task = URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
                if let error = error {
                    return completion(.failure(error))
                }
                if let urlResponse = urlResponse as? HTTPURLResponse, urlResponse.statusCode != 200 {
                    return completion(.failure(NertworkError.unknown))
                }
                guard let data = data else {
                    return completion(.failure(NertworkError.emptyResponse))
                }
                completion(.success(data))
            }
            task.resume()
        } catch {
            completion(.failure(error))
        }
    }

    func makeRequest<T>(_ request: NetworkRequest, completion: @escaping Completion<T, Error>) {
        makeRequest(request) { result in
            switch result {
            case let .success(data):
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(NertworkError.decodingError(error.localizedDescription)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func makeRequest(with request: NetworkRequest) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: request.endpoint) else {
            throw NertworkError.invalidUrl
        }
        urlComponents.queryItems = request.queryParams?.compactMap { key, value in
            URLQueryItem(name: key, value: value)
        }

        guard let url = urlComponents.url else {
            throw NertworkError.invalidParams
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod?.rawValue
        urlRequest.httpBody = request.body
        request.headers?.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }

        return urlRequest
    }
}
