//
//  FlickerService.swift
//  FlickrIMG
//
//  Created by Adit Hasan on 1/18/25.
//

import Foundation
import Combine

protocol FlickrServiceProtocol {
    var apiSession: APISessionProtocol { get }
    func searchFlickrImages(searchItem: String) -> AnyPublisher<FlickrResponse, APIError>}

extension FlickrServiceProtocol {
    func searchFlickrImages(searchItem: String) -> AnyPublisher<FlickrResponse, APIError> {
        apiSession.request(with: Endpoint.searchflickrImages(searchItem: searchItem))
    }
}
