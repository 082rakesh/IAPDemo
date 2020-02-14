//
//  IAPDemoTests.swift
//  IAPDemoTests
//
//  Created by rakesh.e.mishra on 14/01/20.
//  Copyright © 2019 Accenture. All rights reserved.
//

import XCTest
@testable import IAPDemo

class EntrainmentSoundViewModelTests: XCTestCase {
    var viewModel: EntrainmentSoundViewModel?

    override func setUp() {
        super.setUp()
        viewModel = EntrainmentSoundViewModel()
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    func testEntrainmentSoundsLoading() {
        var error: Error?
        let expectation = self.expectation(description: "downloading")
        viewModel?.loadEntrainmentSounds(onSuccess: {
            expectation.fulfill()
        }, onFailure: { (networkError) in
            error = networkError
            expectation.fulfill()
        })
        // Wait for the expectation to be fullfilled, or time out after 5 seconds.
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(error, String(format: "Entrainment sounds download failed with error - %@", error?.localizedDescription ?? ""))
    }
}
