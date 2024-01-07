//
//  FilterViewModel.swift
//
//
//  Created by Kolya Stypanovych on 06/01/2024.
//

import Foundation
import Common

class FilterViewModel: ObservableObject {

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

    init(status: String?, gender: String?) {
        if let status {
            selectedStatus = Status(rawValue: status)
        }
        if let gender {
            selectedGender = Gender(rawValue: gender)
        }
    }

    func onBackButtonPressed() {
        onResult?(.moveBack)
    }

    func selectStatus(selectedStatus: Status?) {
        self.selectedStatus = selectedStatus
    }

    func resetStatus() {
        selectedStatus = nil
    }

    func selectGender(selectedGender: Gender) {
        self.selectedGender = selectedGender
    }

    func resetGender() {
        selectedGender = nil
    }

    func onApplyFilterTapped() {
        onResult?(.applyFilter(selectedStatus?.rawValue, selectedGender?.rawValue))
    }
}
