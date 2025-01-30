//
//  XCTestCase+Extension.swift
//  FlickrIMG
//
//  Created by Adit Hasan on 1/18/25.
//

import XCTest
@testable import FlickrIMG

extension XCTestCase {
    func getExpectationWith(time: Int = 2) -> XCTWaiter.Result {
        let expectation = expectation(description: "Test after \(time) seconds")
        let result = XCTWaiter.wait(for: [expectation], timeout: TimeInterval(time))
        return result
    }
}
