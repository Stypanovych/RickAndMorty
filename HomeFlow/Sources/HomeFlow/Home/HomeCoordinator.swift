//
//  HomeCoordinator.swift
//  RickAndMortyExplorer
//
//  Created by Kolya Stypanovych on 29/12/2023.
//

import Combine
import SwiftUINavigation
import Common
import Domain

public class HomeCoordinator: Coordinator {

    public enum Route {
        case sectionDetails(coordinator: SectionDetailsCoordinator)
    }

    @Published public var route: Route?

    private let factory: HomeCoordinatorFactory
    private var cancellable: AnyCancellable?

    // MARK: Life cycle

    var viewModel: HomeViewModel

    public init(factory: HomeCoordinatorFactory) {
        self.factory = factory
        self.viewModel = HomeViewModel()

        viewModel.onResult = { [weak self] result in
            switch result {
            case .sectionSelected(let section):
                self?.routeSectionDetails(section: section)
            }
        }
    }

    private func routeSectionDetails(section: SectionInfo) {
        let coordinator = factory.makeSectionDetailsCoordinator(section: section)
        coordinator.onResult = { [weak self] result in
            switch result {
            case .moveBack:
                self?.route = nil
            }
        }
        route = .sectionDetails(coordinator: coordinator)
    }
}
