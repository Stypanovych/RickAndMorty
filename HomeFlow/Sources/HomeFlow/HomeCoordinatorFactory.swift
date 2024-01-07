//
//  HomeCoordinatorFactory.swift
//  RickAndMortyExplorer
//
//  Created by Kolya Stypanovych on 29/12/2023.
//

import Foundation
import Domain
import Common

protocol HomeCoordinatorFactoryProtocol {
    func makeCharactersViewModel() -> CharactersSectionViewModel
    func makeSectionDetailsCoordinator(section: SectionInfo) -> SectionDetailsCoordinator
    func makeDetailsCoordinator(character: Characters.CharactersResult) -> DetailsCoordinator
    func makeDetailsViewModel(character: Characters.CharactersResult) -> DetailsViewModel
    func makeFilterCoordinator(status: String?, gender: String?) -> FilterCoordinator
    func makeFilterViewModel(status: String?, gender: String?) -> FilterViewModel
}

public class HomeCoordinatorFactory: HomeCoordinatorFactoryProtocol {

    public init() {}

    func makeCharactersViewModel() -> CharactersSectionViewModel {
        CharactersSectionViewModel(useCase: ServiceContainer.shared.characterUseCase)
    }

    func makeSectionDetailsCoordinator(section: SectionInfo) -> SectionDetailsCoordinator {
        SectionDetailsCoordinator(factory: self, section: section)
    }

    func makeDetailsCoordinator(character: Characters.CharactersResult) -> DetailsCoordinator {
        DetailsCoordinator(factory: self, character: character)
    }

    func makeDetailsViewModel(character: Characters.CharactersResult) -> DetailsViewModel {
        DetailsViewModel(character: character)
    }

    func makeFilterCoordinator(status: String?, gender: String?) -> FilterCoordinator {
        FilterCoordinator(status: status, gender: gender, factory: self)
    }

    func makeFilterViewModel(status: String?, gender: String?) -> FilterViewModel {
        FilterViewModel(status: status, gender: gender)
    }
}
