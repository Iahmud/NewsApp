//
//  NetworkingManager.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import Foundation
import Combine

class NetworkingManager : NSObject {
    static let shared = NetworkingManager()
    
    func fetchDataPublisher<T: Decodable>(_ serviceName: ServiceName) -> AnyPublisher<T, NetworkingError> {
        guard let url = serviceName.url() else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkingError.invalidresponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                (error as? NetworkingError) ?? .invalidJsonData
            }
            .eraseToAnyPublisher()
    }
    
}
