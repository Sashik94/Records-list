//
//  Networking.swift
//  Records list
//
//  Created by Александр Осипов on 07.06.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import Foundation

class NetworkService {
    func request(params: [String: String], completion: @escaping (Data?, Error?) -> Void) {
        guard let url = constructURL(with: params).url else { return }
        var request = URLRequest(url: url)
        
        if let query = url.query {
            request.addValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.addValue(API.token.rawValue, forHTTPHeaderField: "token");
            request.httpBody = query.data(using: .utf8)
            request.httpMethod = "POST"
        }
          
        let task = createDataTask(from: request, completion: completion)
        
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession(configuration: URLSessionConfiguration.default).dataTask(with: request, completionHandler: { (data, _, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
 
    private func constructURL(with params: [String: String]) -> URLComponents {
        var components = URLComponents()
        components.scheme = API.scheme.rawValue
        components.host = API.host.rawValue
        components.path = API.path.rawValue
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components
    }
}
