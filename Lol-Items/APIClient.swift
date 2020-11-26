//
//  APIClient.swift
//  Lol-Items
//
//  Created by Tsering Lama on 11/25/20.
//

import Foundation
import Combine

enum ApiError: Error {
    case badURL(String)
    case networkError(Error)
    case decodingError(Error)
}

class APIClient {
    
    
    public func fetchItems(completion: @escaping (Result<Items, ApiError>) -> ()) {
        
        let endpoint = "https://ddragon.leagueoflegends.com/cdn/10.24.1/data/en_US/item.json"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            if let data = data {
                
                do {
                    let allData = try JSONDecoder().decode(AllData.self, from: data)
                    let dataDict = allData.data
                    
                    for (_,value) in dataDict {
                        completion(.success(value))
                    }
                    return
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        dataTask.resume()
    }
    
//    public func fetchItems() throws -> AnyPublisher<Items, Error> {
//
//        let endpoint = "http://ddragon.leagueoflegends.com/cdn/10.24.1/data/en_US/item.json"
//
//        guard let url = URL(string: endpoint) else {
//            throw ApiError.badURL(endpoint)
//        }
//
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: AllData.self, decoder: JSONDecoder())
//            .map
//
//    }
    
}
