//
//  NetworkingError.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import Foundation

enum NetworkingError: LocalizedError {
    case internetConnection
    case invalidURL
    case invalidJsonData
    case invalidresponse

    var errorDescription: String? {
        switch self {
        case .internetConnection: return "Internet connection error."
        case .invalidURL: return "Invalid URL."
        case .invalidJsonData: return "Failed to decode JSON data."
        case .invalidresponse: return "Invalid response from the server."
        }
    }
}
