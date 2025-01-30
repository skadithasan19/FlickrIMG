//
//  APIError.swift
//  FlickrIMG
//
//  Created by Adit Hasan on 1/18/25.
//

import Foundation

enum APIError: Error {
    case decodingError(error: Error?)
    case httpError(response: HTTPURLResponse, builder: RequestBuilder)
    case unknown(description: String)

    var errorDescription: String? {
        switch self {
        case .decodingError:
            return DecodingError.defaultDecodingError
        case .unknown(let description):
            return description
        case .httpError(response: let response, _):
            switch response.statusCode {
            default:
                return HTTPError.defaultHttpError
            }
        }
    }
}

extension APIError {
    enum DecodingError {
        static let defaultDecodingError = "There was a problem decoding the data from the server. Please try again"
    }
    enum HTTPError {
        static let defaultHttpError = "It looks like there was a problem with your request, please try again."
        static let unknownError = "It looks like there was a problem with your request."
    }
}
