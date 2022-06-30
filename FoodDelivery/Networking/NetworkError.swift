//
//  NetworkError.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 30.06.2022.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidUrlError
    case decodingError
    case serverError(String)
    case unknownError
    case noDataError
    
    var errorDescription: String? {
        switch self {
        case .invalidUrlError:
            return "Invalid URL"
        case .decodingError:
            return "Failed to decode a response"
        case .serverError(let error):
            return error
        case .unknownError:
            return "Something went wrong"
        case .noDataError:
            return "There is no data in network response"
        }
    }
}
