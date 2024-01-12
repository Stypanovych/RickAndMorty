//
//  HomeCoordinatorFactory.swift
//  RickAndMortyExplorer
//
//  Created by Kolya Stypanovych on 29/12/2023.
//

import Foundation
import Domain
import Common

public protocol HomeCoordinatorFactoryProtocol {
    func makeCharactersViewModel() -> CharactersSectionViewModel
    func makeSectionDetailsCoordinator(section: SectionInfo) -> SectionDetailsCoordinator
    func makeDetailsCoordinator(character: Characters.CharactersResult) -> DetailsCoordinator
    func makeDetailsViewModel(character: Characters.CharactersResult) -> DetailsViewModel
    func makeFilterCoordinator(status: String?, gender: String?) -> FilterCoordinator
    func makeFilterViewModel(status: String?, gender: String?) -> FilterViewModel
}

public class HomeCoordinatorFactory: HomeCoordinatorFactoryProtocol {

    public init() {}

    public func makeCharactersViewModel() -> CharactersSectionViewModel {
        CharactersSectionViewModelImpl(useCase: ServiceContainer.shared.characterUseCase)
    }

    public func makeSectionDetailsCoordinator(section: SectionInfo) -> SectionDetailsCoordinator {
        SectionDetailsCoordinatorImpl(factory: self, section: section)
    }

    public func makeDetailsCoordinator(character: Characters.CharactersResult) -> DetailsCoordinator {
        DetailsCoordinatorImpl(factory: self, character: character)
    }

    public func makeDetailsViewModel(character: Characters.CharactersResult) -> DetailsViewModel {
        DetailsViewModelImpl(character: character)
    }

    public func makeFilterCoordinator(status: String?, gender: String?) -> FilterCoordinator {
        FilterCoordinatorImpl(status: status, gender: gender, factory: self)
    }

    public func makeFilterViewModel(status: String?, gender: String?) -> FilterViewModel {
        FilterViewModelImpl(status: status, gender: gender)
    }
}
