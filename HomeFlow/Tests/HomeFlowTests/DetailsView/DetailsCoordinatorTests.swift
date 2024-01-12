//
//  DetailsCoordinatorImplTests.swift
//  
//
//  Created by Kolya Stypanovych on 12/01/2024.
//

import XCTest
import Combine
import Domain
@testable import HomeFlow

class DetailsCoordinatorImplTests: XCTestCase {

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
        origin: Characters.Origin(
            name: "Earth",
            url: "https://example.com/earth"
        ), 
        location: Characters.Location(
            name: "Location",
            url: "https://example.com/location"
        )
    )

    func testDetailsCoordinatorInit() {
        let factoryMock = HomeCoordinatorFactoryMock()
        let detailsCoordinator = DetailsCoordinatorImpl(factory: factoryMock, character: character)
        XCTAssertNotNil(detailsCoordinator)
        XCTAssertNotNil(detailsCoordinator.viewModel)
        XCTAssertEqual(detailsCoordinator.viewModel.character, character)
    }

    func testDetailsCoordinatorOnResult() {
        let factoryMock = HomeCoordinatorFactoryMock()
        let detailsCoordinator = DetailsCoordinatorImpl(factory: factoryMock, character: character)

        let expectation = expectation(description: "\(#function)")

        detailsCoordinator.onResult = { result in
            XCTAssertEqual(result, .moveBack)
            expectation.fulfill()
        }

        detailsCoordinator.viewModel.onResult?(.moveBack)
        wait(for: [expectation], timeout: 1.0)
    }
}

