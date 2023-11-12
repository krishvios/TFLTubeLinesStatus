//
//  NetworkManager.swift
//  VMDirectory
//
//  Created by ANSK Vivek on 20/07/23.
//

import Foundation
import Combine

class NetworkManager {
    
    private let session = URLSession.shared
    static let sharedInstance = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    /// Make Network Request
    typealias RequestCompletionHandler<T: Decodable> = (_ value: T?, _ error: Error?) -> Void
    
    func getData<T: Decodable>(endPoint: String? = nil, parameters: [String: String], type: T.Type) -> Future<[T], Error> {
        
        var components = URLComponents(string: Constants.baseURL)!
        if let endPoint = endPoint {
            components.path = endPoint
        }
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

        return Future<[T], Error> { [weak self] promise in
            guard let self = self, let url = URL(string: Constants.baseURL.appending(endPoint!)) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: [T].self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { line in
                    promise(.success(line))
                })
                .store(in: &self.cancellables)
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
    case noData
    case decode
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: "Invalid URL"
        case .responseError: "Unexpected status code"
        case .unknown: "Unknown error"
        case .noData: "Unable to get the data."
        case .decode: "Error while decoding the data."
        }
    }
}
