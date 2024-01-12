//
//  HomeCoordinatorFactoryTests.swift
//
//
//  Created by Kolya Stypanovych on 12/01/2024.
//

import XCTest
import Domain
@testable import HomeFlow

class HomeCoordinatorFactoryTests: XCTestCase {

    private let characters: Characters.CharactersResult = .init(
        id: 0,
        name: String(),
        status: String(),
        species: String(),
        type: String(),
        gender: String(),
        url: String(),
        created: String(),
        episode: [],
        image: String(),
        origin: .init(name: String(), url: String()),
        location: .init(name: String(), url: String())
    )

    // MARK: - Test makeCharactersViewModel

    func testMakeCharactersViewModel() {
        let factory = HomeCoordinatorFactory()

        let charactersViewModel = factory.makeCharactersViewModel()

        XCTAssertNotNil(charactersViewModel)
    }

    // MARK: - Test makeSectionDetailsCoordinator

    func testMakeSectionDetailsCoordinator() {
        let factory = HomeCoordinatorFactory()
        let sectionDetailsCoordinator = factory.makeSectionDetailsCoordinator(section: .characters)

        XCTAssertNotNil(sectionDetailsCoordinator)
    }

    // MARK: - Test makeDetailsCoordinator

    func testMakeDetailsCoordinator() {
        let factory = HomeCoordinatorFactory()

        let detailsCoordinator = factory.makeDetailsCoordinator(character: characters)
        XCTAssertNotNil(detailsCoordinator)
    }

    // MARK: - Test makeDetailsViewModel

    func testMakeDetailsViewModel() {
        let factory = HomeCoordinatorFactory()

        let detailsViewModel = factory.makeDetailsViewModel(character: characters)

        XCTAssertNotNil(detailsViewModel)
    }

    // MARK: - Test makeFilterCoordinator

    func testMakeFilterCoordinator() {
        let factory = HomeCoordinatorFactory()
        let filterCoordinator = factory.makeFilterCoordinator(status: "Alive", gender: "Male")
        XCTAssertNotNil(filterCoordinator)
    }

    // MARK: - Test makeFilterViewModel

    func testMakeFilterViewModel() {
        let factory = HomeCoordinatorFactory()
        let filterViewModel = factory.makeFilterViewModel(status: "Alive", gender: "Male")
        XCTAssertNotNil(filterViewModel)
    }
}
