//
//  FilterCoordinatorImpl.swift
//  
//
//  Created by Kolya Stypanovych on 12/01/2024.
//

import XCTest
@testable import HomeFlow

class FilterCoordinatorImplTests: XCTestCase {

    func testFilterCoordinatorImplOnResultMoveBack() {
        let factoryMock = HomeCoordinatorFactoryMock()
        let filterCoordinatorImpl = FilterCoordinatorImpl(status: nil, gender: nil, factory: factoryMock)

        let expectation = XCTestExpectation(description: "Filter Coordinator On Result - Move Back")

        filterCoordinatorImpl.onResult = { result in
            XCTAssertEqual(result, .moveBack)
            expectation.fulfill()
        }

        filterCoordinatorImpl.onResult?(.moveBack)

        wait(for: [expectation], timeout: 1.0)
    }

    func testFilterCoordinatorImplOnResultApplyFilters() {
        let factoryMock = HomeCoordinatorFactoryMock()
        let filterCoordinatorImpl = FilterCoordinatorImpl(status: "Alive", gender: "Male", factory: factoryMock)

        let expectation = XCTestExpectation(description: "Filter Coordinator On Result - Apply Filters")

        filterCoordinatorImpl.onResult = { result in
            XCTAssertEqual(result, .applyFilters("Alive", "Male"))
            expectation.fulfill()
        }

        filterCoordinatorImpl.viewModel.onResult?(.applyFilter("Alive", "Male"))

        wait(for: [expectation], timeout: 1.0)
    }
}
