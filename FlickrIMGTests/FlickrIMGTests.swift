//
//  FlickrIMGTests.swift
//  FlickrIMGTests
//
//  Created by Adit Hasan on 1/18/25.
//

import Testing
@testable import FlickrIMG
import XCTest
import Combine


class FlickrViewModelTests: XCTestCase {
    
    var viewModel: FlickrViewModel!
    
    let  mockApiSession = MockApiSession<FlickrResponse, APIError>()
    
    override func setUpWithError() throws {
        
        mockApiSession.stub.expectedReturnData = getMockJSON(fileName: "FlickrResponse")
        viewModel = FlickrViewModel(apiSession: mockApiSession, searchText: "porcupine")
        viewModel.load()
    }
    
    func test_loadedFlickrResponse() {
        let result = getExpectationWith()
        if result == XCTWaiter.Result.timedOut {
            if case .loaded(let response) = viewModel?.state {
                XCTAssertFalse(response.link.isEmpty)
                XCTAssertFalse(response.title.isEmpty)
                XCTAssertFalse(response.generator.isEmpty)
                XCTAssertTrue(response.description.isEmpty)
                XCTAssertTrue(response.items.count == 20)
            }
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func test_loadedFlickrPhotoItems() {
        let result = getExpectationWith()
        if result == XCTWaiter.Result.timedOut {
            if case .loaded(let response) = viewModel?.state {
                XCTAssertNotNil(response.items.first)
                if let photoItem = response.items.first {
                    XCTAssertFalse(photoItem.title.isEmpty)
                    XCTAssertFalse(photoItem.media.m.isEmpty)
                    XCTAssertFalse(photoItem.link.isEmpty)
                    XCTAssertFalse(photoItem.dateTaken.isEmpty)
                    XCTAssertFalse(photoItem.author.isEmpty)
                    XCTAssertFalse(photoItem.tags.isEmpty)
                }
            }
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    
    func getMockJSON(fileName: String) -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                return data
            } catch let error {
                print("Parse error: \(error.localizedDescription)")
                return nil
            }
        } else {
            return nil
        }
    }
    
    func getFlickrResponse() -> FlickrResponse? {
        guard let jsonData = getMockJSON(fileName: "Meals") else { return nil }
        do {
            return try JSONDecoder().decode(FlickrResponse.self, from: jsonData)
        } catch {
            return nil
        }
    }
}
