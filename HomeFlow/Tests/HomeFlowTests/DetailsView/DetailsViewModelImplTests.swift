//
//  DetailsViewModelImplTests.swift
//
//
//  Created by Kolya Stypanovych on 12/01/2024.
//

import XCTest
import Domain
@testable import HomeFlow

class DetailsViewModelImplTests: XCTestCase {

    func testOnBackButtonPressed() {
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

        let viewModel = DetailsViewModelImpl(character: character)

        let expectation = expectation(description: "\(#function)")

        viewModel.onResult = { result in
            XCTAssertEqual(result, .moveBack)
            expectation.fulfill()
        }

        viewModel.onBackButtonPressed()

        wait(for: [expectation], timeout: 1.0)
    }
}
