//
//  CharactersSectionViewModelImplTests.swift
//
//
//  Created by Kolya Stypanovych on 12/01/2024.
//

import XCTest
import Combine
import Domain
@testable import HomeFlow

enum TestError: Error {
    case mockError
}

class CharactersSectionViewModelImplTests: XCTestCase {

    func testFetchDataSuccess() throws {
        let mock = CharactersUseCaseMock()
        let info = Characters(
            info: .init(
                count: 0,
                pages: 1,
                next: nil,
                prev: nil
            ),
            results: []
        )
        mock.response = .success(info)
        let sut = CharactersSectionViewModelImpl(useCase: mock)

        let expectation = expectation(description: "\(#function)")

        let cancellable = sut.$characters
            .dropFirst()
            .sink { value in
                XCTAssertEqual(info.results, value)
                expectation.fulfill()
            }

        sut.fetchData()

        wait(for: [expectation], timeout: 1)
        cancellable.cancel()
    }

    func testGetDataError() {
        let mock = CharactersUseCaseMock()
        mock.response = .error(TestError.mockError)
        let sut = CharactersSectionViewModelImpl(useCase: mock)

        let expectation = expectation(description: "\(#function)")

        let cancellable = sut.$errorDescription
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value, TestError.mockError.localizedDescription)
                expectation.fulfill()
            }

        sut.fetchData()

        wait(for: [expectation], timeout: 1)
        cancellable.cancel()
    }

    func testOnBackButtonPressed() {
        let viewModel = CharactersSectionViewModelImpl(useCase: CharactersUseCaseMock())
        let expectation = expectation(description: "\(#function)")

        viewModel.onResult = { result in
            XCTAssertEqual(result, .moveBack)
            expectation.fulfill()
        }

        viewModel.onBackButtonPressed()
        wait(for: [expectation], timeout: 1.0)
    }

    func testOnFilterPressed() {
        let viewModel = CharactersSectionViewModelImpl(useCase: CharactersUseCaseMock())
        let expectation = expectation(description: "\(#function)")

        viewModel.onResult = { result in
            XCTAssertEqual(result, .showFilter(nil, nil))
            expectation.fulfill()
        }

        viewModel.onFilterPressed()

        wait(for: [expectation], timeout: 1.0)
    }

    func testOnCharacterPressed() {
        let viewModel = CharactersSectionViewModelImpl(useCase: CharactersUseCaseMock())
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
        let expectation = expectation(description: "\(#function)")

        viewModel.onResult = { result in
            XCTAssertEqual(result, .showDetails(character))
            expectation.fulfill()
        }

        viewModel.onCharacterPressed(character)
        wait(for: [expectation], timeout: 1.0)
    }
}
