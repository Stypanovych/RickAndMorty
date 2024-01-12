//
//  SectionDetailsCoordinatorImplTests 2.swift
//
//
//  Created by Kolya Stypanovych on 12/01/2024.
//

import Foundation
import XCTest
import Domain
@testable import HomeFlow

class SectionDetailsCoordinatorImplTests: XCTestCase {

    let character = Characters.CharactersResult(
        id: 1,
        name: "TestCharacter",
        status: "Alive",
        species: "Human",
        type: "Test",
        gender: "Male",
        url: "https://example.com",
        created: "2024-01-12",
        episode: ["S01E01"],
        image: "https://example.com/image.jpg",
        origin: Characters.Origin(name: "Earth", url: "https://example.com/earth"),
        location: Characters.Location(name: "Location", url: "https://example.com/location")
    )

    func testRouteToFilter() {
        let factoryMock = HomeCoordinatorFactoryMock()
        let sectionDetailsCoordinatorImpl = SectionDetailsCoordinatorImpl(factory: factoryMock, section: .characters)
        let status = "Alive"
        let gender = "Male"

        sectionDetailsCoordinatorImpl.viewModel.onResult?(.showFilter(status, gender))

        XCTAssertNotNil(sectionDetailsCoordinatorImpl.route)
        if case .filter(let coordinator) = sectionDetailsCoordinatorImpl.route {
            XCTAssertNotNil(coordinator)
        } else {
            XCTFail("Expected .filter route")
        }
    }

    func testFilterResultMoveBack() {
        // Arrange
        let factoryMock = HomeCoordinatorFactoryMock()
        let sectionDetailsCoordinatorImpl = SectionDetailsCoordinatorImpl(factory: factoryMock, section: .characters)
        let status = "Alive"
        let gender = "Male"

        sectionDetailsCoordinatorImpl.viewModel.onResult?(.showFilter(status, gender))
        guard case .filter(let coordinator) = sectionDetailsCoordinatorImpl.route else {
            XCTFail("Expected .filter route")
            return
        }

        let expectation = expectation(description: "\(#function)")

        coordinator.onResult?(.moveBack)
        XCTAssertNil(sectionDetailsCoordinatorImpl.route)
        expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)
    }

    func testFilterResultApplyFilters() {
        let factoryMock = HomeCoordinatorFactoryMock()
        let sectionDetailsCoordinatorImpl = SectionDetailsCoordinatorImpl(factory: factoryMock, section: .characters)
        let status = "Alive"
        let gender = "Male"

        sectionDetailsCoordinatorImpl.viewModel.onResult?(.showFilter(status, gender))

        let expectation = expectation(description: "\(#function)")
        if case .filter(let coordinator) = sectionDetailsCoordinatorImpl.route {
            coordinator.onResult?(.applyFilters(status, gender))
            XCTAssertNil(sectionDetailsCoordinatorImpl.route)
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)
    }

    func testRouteToDetailsScreen() {
        let factoryMock = HomeCoordinatorFactoryMock()
        let sectionDetailsCoordinatorImpl = SectionDetailsCoordinatorImpl(factory: factoryMock, section: .characters)
        sectionDetailsCoordinatorImpl.viewModel.onResult?(.showDetails(character))

        XCTAssertNotNil(sectionDetailsCoordinatorImpl.route)
        if case .details(let coordinator) = sectionDetailsCoordinatorImpl.route {
            XCTAssertNotNil(coordinator)
        } else {
            XCTFail("Expected .details route")
        }
    }

    func testDetailsResultMoveBack() {
        let factoryMock = HomeCoordinatorFactoryMock()
        let sectionDetailsCoordinatorImpl = SectionDetailsCoordinatorImpl(factory: factoryMock, section: .characters)
        sectionDetailsCoordinatorImpl.viewModel.onResult?(.showDetails(character))

        guard case .details(let coordinator) = sectionDetailsCoordinatorImpl.route else {
            XCTFail("Expected .details route")
            return
        }

        let expectation = expectation(description: "\(#function)")
        coordinator.onResult?(.moveBack)
        XCTAssertNil(sectionDetailsCoordinatorImpl.route)
        expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)
    }
}
