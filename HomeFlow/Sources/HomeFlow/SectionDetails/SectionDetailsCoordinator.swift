//
//  SectionDetailsCoordinator.swift
//  RickAndMortyExplorer
//
//  Created by Kolya Stypanovych on 02/01/2024.
//

import Combine
import SwiftUINavigation
import Domain
import Common

public class SectionDetailsCoordinator: Coordinator {

    public enum Route {
        case details(coordinator: DetailsCoordinator)
        case filter(coordinator: FilterCoordinator)
    }

    enum Result: Equatable {
        case moveBack
    }

    @Published public var route: Route?
    var onResult: ((Result) -> Void)?

    var viewModel: CharactersSectionViewModel

    init() {
        self.viewModel = CharactersSectionViewModel()
    }
}

public class SectionDetailsCoordinatorImpl: SectionDetailsCoordinator {

    private let factory: HomeCoordinatorFactoryProtocol

    init(factory: HomeCoordinatorFactoryProtocol, section: SectionInfo) {
        self.factory = factory
        super.init()
        self.viewModel = factory.makeCharactersViewModel()

        viewModel.onResult = { [weak self] result in
            switch result {
            case .moveBack:
                self?.onResult?(.moveBack)
            case .showFilter(let status, let gender):
                self?.routeToFilter(status: status, gender: gender)
            case .showDetails(let character):
                self?.routeToDetailsScreen(character: character)
            }
        }
    }

    private func routeToFilter(status: String?, gender: String?) {
        let coordinator = factory.makeFilterCoordinator(status: status, gender: gender)

        coordinator.onResult = { [weak self] result in
            switch result {
            case .moveBack:
                self?.route = nil
            case .applyFilters(let status, let gender):
                self?.viewModel.setFilters(status: status, gender: gender)
                self?.route = nil
            }
        }
        route = .filter(coordinator: coordinator)
    }

    private func routeToDetailsScreen(character: Characters.CharactersResult) {
        let coordinator = factory.makeDetailsCoordinator(character: character)

        coordinator.onResult = { [weak self] result in
            switch result {
            case .moveBack:
                self?.route = nil
            }
        }
        route = .details(coordinator: coordinator)
    }
}
