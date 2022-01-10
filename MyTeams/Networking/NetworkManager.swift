//
//  NetworkManager.swift
//  MyTeams
//
//  Created by Martin Bucko on 19/12/2021.
//

import Foundation

class NetworkManager {
    
    func loadImage(url: URL?, completion: @escaping (Data?) -> Void) {
        guard let url = url else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(data)
        }.resume()
    }
    
    func request<T: Decodable>(endpointEnum: EndpointEnum, parameters: [String: String]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        var endpoint = endpointEnum.endpoint
        endpoint.parameters = parameters
        
        request(url: endpoint.url, httpMethod: endpoint.httpMethod, headers: endpoint.headers, completion: completion)
    }
    
    func request<T: Decodable>(url: URL?, httpMethod: String, headers: [String: String]?, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }

            do {
                print(String(data: data, encoding: .utf8)!)
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    //MOCK
    func request<T: Decodable>(json: Data, parameters: [String: String]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: json)
                print(decodedData)
                completion(.success(decodedData))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
    }
}
