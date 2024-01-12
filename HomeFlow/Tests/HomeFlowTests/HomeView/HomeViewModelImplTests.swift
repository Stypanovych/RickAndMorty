//
//  HomeViewModelImplTests.swift
//
//
//  Created by Kolya Stypanovych on 12/01/2024.
//

import XCTest
@testable import HomeFlow // Replace with your module name

class HomeViewModelImplTests: XCTestCase {

    func testOnSelect() {
        let viewModel = HomeViewModelImpl()

        let expectation = expectation(description: "\(#function)")

        viewModel.onResult = { result in
            XCTAssertEqual(result, .sectionSelected(section: .characters))
            expectation.fulfill()
        }

        viewModel.onSelect(section: .characters)

        wait(for: [expectation], timeout: 1.0)
    }
}
