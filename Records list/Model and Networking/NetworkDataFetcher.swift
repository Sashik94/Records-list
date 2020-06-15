//
//  NetworkDataFetcher.swift
//  Records list
//
//  Created by Александр Осипов on 07.06.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
    
    let networking = NetworkService()
    
    func fetchJSONData<T: Decodable>(params: [String: String], response: @escaping (T?, Error?) -> Void) {
        networking.request(params: params) { (data, error) in
            guard let data = data else {
                return response(nil, error)
            }
            let decoded = self.decodeJSON(type: T.self, from: data)
            response(decoded, nil)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data) -> T? {
        let decoder = JSONDecoder()

        do {
            return try decoder.decode(type.self, from: data)
        } catch let error {
            print("Error is: ", error)
            return nil
        }
    }
}
