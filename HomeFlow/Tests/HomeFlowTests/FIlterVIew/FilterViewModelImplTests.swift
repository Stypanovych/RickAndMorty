//
//  FilterViewModelImplTests.swift
//
//
//  Created by Kolya Stypanovych on 12/01/2024.
//

import XCTest
@testable import HomeFlow

class FilterViewModelImplTests: XCTestCase {

    func testOnBackButtonPressed() {
        let viewModel = FilterViewModelImpl(status: "Alive", gender: "Female")
        let expectation = expectation(description: "\(#function)")

        viewModel.onResult = { result in
            XCTAssertEqual(result, .moveBack)
            expectation.fulfill()
        }
        viewModel.onBackButtonPressed()
        wait(for: [expectation], timeout: 1.0)
    }

    func testOnApplyFilterTapped() {
        let viewModel = FilterViewModelImpl(status: "Alive", gender: "Female")
        let expectation = expectation(description: "\(#function)")
        viewModel.onResult = { result in
            XCTAssertEqual(result, .applyFilter("alive", "female"))
            expectation.fulfill()
        }
        viewModel.onApplyFilterTapped()
        wait(for: [expectation], timeout: 1.0)
    }

    func testSelectStatus() {
        let viewModel = FilterViewModelImpl(status: nil, gender: nil)
        viewModel.selectStatus(selectedStatus: .alive)
        XCTAssertEqual(viewModel.selectedStatus, .alive)
    }

    func testResetStatus() {
        let viewModel = FilterViewModelImpl(status: "Alive", gender: "Female")
        viewModel.resetStatus()
        XCTAssertNil(viewModel.selectedStatus)
    }

    func testSelectGender() {
        let viewModel = FilterViewModelImpl(status: nil, gender: nil)
        viewModel.selectGender(selectedGender: .male)
        XCTAssertEqual(viewModel.selectedGender, .male)
    }

    func testResetGender() {
        let viewModel = FilterViewModelImpl(status: "Alive", gender: "Female")
        viewModel.resetGender()
        XCTAssertNil(viewModel.selectedGender)
    }
}
