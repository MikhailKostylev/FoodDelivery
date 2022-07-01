//
//  NetworkService.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 30.06.2022.
//

import Foundation

struct NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    // MARK: - Public methods
    
    func fetchAllCategories(completion: @escaping (Result<AllDishes, Error>) -> Void) {
        request(route: .fetchAllCategories, method: .get, completion: completion)
    }
    
    func placeOrder(dishId: String, name: String, completion: @escaping (Result<Order, Error>) -> Void) {
        let parameters = ["name": name]
        request(route: .placeOrder(dishId), method: .post, parameters: parameters, completion: completion)
    }
    func fetchCategoryDishes(categoryId: String, completion: @escaping (Result<[Dish], Error>) -> Void) {
        request(route: .fetchCategoryDishes(categoryId), method: .get, completion: completion)
    }
    
    // MARK: - Private methods
    
    /// Make a network request.
    /// - Parameters:
    ///   - route: The path to the resource in the backend.
    ///   - method: Type of request to be made.
    ///   - parameters: Additional information that can be passed to the backend.
    ///   - completion: Causes feedback depending on the result.
    private func request<T: Codable>(
        route: Route,
        method: Method,
        parameters: [String: Any]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(NetworkError.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            var result: Result<Data, Error>?
            
            if let data = data {
                result = .success(data)
            } else if let error = error {
                result = .failure(error)
            }
            
            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
    }
    
    /// Handle network response.
    /// - Parameters:
    ///   - result: Result of network request.
    ///   - completion: Causes feedback depending on the result.
    private func handleResponse<T: Codable>(
        result: Result<Data, Error>?,
        completion: (Result<T, Error>) -> Void) {
        
        guard let result = result else {
            completion(.failure(NetworkError.unknownError))
            return
        }
        
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(APIResponse<T>.self, from: data) else {
                completion(.failure(NetworkError.decodingError))
                return
            }
            
            if let error = response.error {
                completion(.failure(NetworkError.serverError(error)))
            }
            
            if let decodedData = response.data {
                completion(.success(decodedData))
            } else {
                completion(.failure(NetworkError.noDataError))
            }
            
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    /// Create a URLRequest.
    /// - Parameters:
    ///   - route: The path to the resource in the backend.
    ///   - method: Type of request to be made.
    ///   - parameters: Additional information that can be passed to the backend.
    /// - Returns: URLRequest
    private func createRequest(
        route: Route,
        method: Method,
        parameters: [String: Any]? = nil
    ) -> URLRequest? {
        
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
