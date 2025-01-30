//
//  Endpoint.swift
//  FlickrIMG
//
//  Created by Adit Hasan on 1/18/25.
//

import Foundation
import Combine

protocol RequestBuilder {
    var urlRequest: URLRequest { get }
}

protocol APISessionProtocol {
    func request<T: Decodable>(with builder: RequestBuilder) -> AnyPublisher<T, APIError>
}

enum Endpoint {
    case searchflickrImages(searchItem: String)
}

extension Endpoint: RequestBuilder {
    var urlRequest: URLRequest {
        switch self {
        case .searchflickrImages(let searchItem):
            guard let url =  URLs.flickrImages(searchItem: searchItem).url else { preconditionFailure("Invalid URL format") }
            print(url)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        }
    }
}
