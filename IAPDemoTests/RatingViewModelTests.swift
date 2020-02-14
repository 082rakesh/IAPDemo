//
//  RatingViewModelTests.swift
//  IAPDemoTests
//
//  Created by rakesh.e.mishra on 22/01/20.
//  Copyright © 2019 Accenture. All rights reserved.
//

import XCTest
@testable import IAPDemo

class RatingViewModelTests: XCTestCase {
    var viewModel: RatingViewModel?

    override func setUp() {
        super.setUp()
        viewModel = RatingViewModel()
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    func testRatingImageType() {
        let rating = 1
        let type = viewModel?.starImage(at: 1, for: rating)
        XCTAssertEqual(type, RatingImageType.fullStarImage, "Rating image did not match the rating")
    }
}
