//
//  MockAPISession.swift
//  FlickrIMG
//
//  Created by Adit Hasan on 1/18/25.
//
import Foundation
import Combine
@testable import FlickrIMG

struct MockApiSession<Output: Decodable, Failure: Error>: APISessionProtocol {
    class Stub {
        var expectedResult: Result<Output?, APIError> = .success(nil)
        var expectedReturnData: Data?
    }
    var stub = Stub()
    func request<T>(with builder: RequestBuilder) -> AnyPublisher<T, APIError> where T : Decodable {
        if let returnData = stub.expectedReturnData, case .success = stub.expectedResult {
            let result = try! JSONDecoder().decode(Output.self, from: returnData)
            if let rr = result as? T {
                return Result.Publisher(rr).eraseToAnyPublisher()
            } else {
                return Result.Publisher(APIError.decodingError(error: NSError(domain: "Decoding Error", code: -1))).eraseToAnyPublisher()
            }
            
        } else if case .failure(let error) = stub.expectedResult {
            return Result.Publisher(error).eraseToAnyPublisher()
        } else {
            fatalError("Bad test data")
        }
    }

    func requestImage(with builder: RequestBuilder) -> AnyPublisher<Data, APIError> {
        Result.Publisher(.failure(APIError.unknown(description: "No Reponse"))).eraseToAnyPublisher()
    }
}

