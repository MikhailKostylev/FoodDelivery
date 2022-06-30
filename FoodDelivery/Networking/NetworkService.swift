//
//  NetworkService.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 30.06.2022.
//

import Foundation

struct NetworkService {
    
    /// Create a URLRequest
    /// - Parameters:
    ///   - route: The path to the resource in the backend.
    ///   - method: Type of request to be made.
    ///   - parameters: Additional information that can be passed to the backend.
    /// - Returns: URLRequest
    func createRequest(route: Route, method: Method, parameters: [String: Any]? = nil) -> URLRequest? {
        
        /// Setup URL
        let urlString = Route.baseUrl + route.description
        guard let url = urlString.asUrl else { return nil }
        
        /// Setup Request
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        /// Setup parameters
        if let parameters = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = parameters.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponent?.url
                
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        
        return urlRequest
    }
}
