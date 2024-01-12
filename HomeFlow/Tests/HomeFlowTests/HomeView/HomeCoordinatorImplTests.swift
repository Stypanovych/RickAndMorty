//
//  HomeCoordinatorImplTests.swift
//
//
//  Created by Kolya Stypanovych on 12/01/2024.
//

import XCTest
import Combine
import Domain
@testable import HomeFlow

class HomeCoordinatorImplTests: XCTestCase {

    func testRouteSectionDetails() {
        let factoryMock = HomeCoordinatorFactoryMock()
        let homeCoordinatorImpl = HomeCoordinatorImpl(factory: factoryMock)

        homeCoordinatorImpl.viewModel.onResult?(.sectionSelected(section: .characters))

        XCTAssertNotNil(homeCoordinatorImpl.route)
        if case .sectionDetails(let coordinator) = homeCoordinatorImpl.route {
            XCTAssertNotNil(coordinator)
        } else {
            XCTFail("Expected .sectionDetails route")
        }
    }

    func testMoveBack() {
        let factoryMock = HomeCoordinatorFactoryMock()
        let homeCoordinatorImpl = HomeCoordinatorImpl(factory: factoryMock)
        homeCoordinatorImpl.viewModel.onResult?(.sectionSelected(section: .characters))
        
        guard case .sectionDetails(let coordinator) = homeCoordinatorImpl.route else {
            XCTFail("Expected .sectionDetails route")
            return
        }

        let expectation = expectation(description: "\(#function)")

        coordinator.onResult?(.moveBack)

        XCTAssertNil(homeCoordinatorImpl.route)
        expectation.fulfill()

        wait(for: [expectation], timeout: 1.0)
    }
}
