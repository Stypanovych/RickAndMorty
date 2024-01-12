//
//  HomeCoordinatorFactoryMock.swift
//  
//
//  Created by Kolya Stypanovych on 12/01/2024.
//

import Foundation
import Domain
@testable import HomeFlow

class HomeCoordinatorFactoryMock: HomeCoordinatorFactoryProtocol {
    func makeCharactersViewModel() -> CharactersSectionViewModel {
        CharactersSectionViewModel()
    }

    func makeSectionDetailsCoordinator(section: SectionInfo) -> SectionDetailsCoordinator {
        SectionDetailsCoordinator()
    }

    func makeDetailsCoordinator(character: Characters.CharactersResult) -> DetailsCoordinator {
        DetailsCoordinator(character: character)
    }

    func makeDetailsViewModel(character: Characters.CharactersResult) -> DetailsViewModel {
        DetailsViewModel(character: character)
    }

    func makeFilterCoordinator(status: String?, gender: String?) -> FilterCoordinator {
        FilterCoordinator(status: status, gender: gender, factory: self)
    }

    func makeFilterViewModel(status: String?, gender: String?) -> FilterViewModel {
        FilterViewModel()
    }
}
