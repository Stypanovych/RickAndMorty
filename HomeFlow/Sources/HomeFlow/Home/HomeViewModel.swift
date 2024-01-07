//
//  HomeViewModel.swift
//  RickAndMortyExplorer
//
//  Created by Kolya Stypanovych on 02/01/2024.
//

import Foundation
import Domain

class HomeViewModel: ObservableObject {

    enum Result {
        case sectionSelected(section: SectionInfo)
    }

    var onResult: ((Result) -> Void)?

    func onSelect(section: SectionInfo) {
        onResult?(.sectionSelected(section: section)) // we opens only characters view but if we have the same UI for those screens we may have only different VMs
    }
}
