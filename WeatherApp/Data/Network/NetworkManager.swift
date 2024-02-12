//
//  NetworkManager.swift
//  Vocal Remover
//
//  Created by Dmitry Lipuntsov on 06.07.2023.
//

import Foundation
import Combine

enum HttpMethod {
    case get
    case post
    case put
    case delete
    
    var string: String {
        return String(describing: self).uppercased()
    }
}

protocol NetworkManagerProtocol: AnyObject {
    typealias Headers = [String: Any]
    
    func request<T>(
        type: T.Type,
        url: URL,
        method: HttpMethod,
        headers: Headers,
        body: Data?
    ) -> AnyPublisher<T, Error> where T: Decodable
}

class NetworkManager: NetworkManagerProtocol {
    private let decoder = JSONDecoder()
    
    func request<T: Decodable>(
        type: T.Type,
        url: URL,
        method: HttpMethod,
        headers: Headers,
        body: Data?
    ) -> AnyPublisher<T, Error> {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.string
        
//        if let body = body {
//            urlRequest.httpBody = body
//            let utf8Text = String(data: body, encoding: .utf8)
//            print(utf8Text)
//        }
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .handleEvents(receiveOutput: { response in
//                print("Response: \(response)")
//                let utf8Text = String(data: response.data, encoding: .utf8)
//                print(utf8Text)
            })
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

extension NetworkManager {
    static func getImage(
        url: URL,
        headers: Headers
    ) -> AnyPublisher<Data, URLError> {
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest).map(\.data).eraseToAnyPublisher()
    }
}
