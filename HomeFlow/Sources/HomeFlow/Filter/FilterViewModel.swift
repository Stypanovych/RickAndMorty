//
//  FilterViewModel.swift
//
//
//  Created by Kolya Stypanovych on 06/01/2024.
//

import Foundation
import Common

public class FilterViewModel: ObservableObject {

    enum Status: String, CaseIterable, Identifiable, FilterEnumProtocol {
        case alive
        case dead
        case unknown

        var id: String {
            self.rawValue
        }

        var title: String {
            switch self {
            case .alive: "Alive"
            case .dead: "Dead"
            case .unknown: "Unknown"
            }
        }
    }

    enum Gender: String, CaseIterable, Identifiable, FilterEnumProtocol {
        case female
        case male
        case genderless
        case unknown

        var id: String {
            self.rawValue
        }

        var title: String {
            switch self {
            case .female: "Female"
            case .genderless: "Genderless"
            case .male: "Male"
            case .unknown: "Unknown"
            }
        }
    }

    enum Result: Equatable {
        case moveBack
        case applyFilter(String?, String?)
    }

    @Published var selectedStatus: Status?
    @Published var selectedGender: Gender?

    var onResult: ((Result) -> Void)?

    init() {}

    func onBackButtonPressed() {}

    func selectStatus(selectedStatus: Status?) {}

    func resetStatus() {}

    func selectGender(selectedGender: Gender) {}

    func resetGender() {}

    func onApplyFilterTapped() {}
}

public class FilterViewModelImpl: FilterViewModel {

    init(status: String?, gender: String?) {
        super.init()
        if let status {
            selectedStatus = Status(rawValue: status.lowercased())
        }
        if let gender {
            selectedGender = Gender(rawValue: gender.lowercased())
        }
    }

    override func onBackButtonPressed() {
        onResult?(.moveBack)
    }

    override func selectStatus(selectedStatus: Status?) {
        self.selectedStatus = selectedStatus
    }

    override func resetStatus() {
        selectedStatus = nil
    }

    override func selectGender(selectedGender: Gender) {
        self.selectedGender = selectedGender
    }

    override func resetGender() {
        selectedGender = nil
    }

    override func onApplyFilterTapped() {
        onResult?(.applyFilter(selectedStatus?.rawValue, selectedGender?.rawValue))
    }
}
