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

    var viewModel: HomeViewModel

    public init() {
        self.viewModel = HomeViewModel()
    }

    private func routeSectionDetails(section: SectionInfo) {}
}

public class HomeCoordinatorImpl: HomeCoordinator {



    private let factory: HomeCoordinatorFactoryProtocol
    private var cancellable: AnyCancellable?

    public init(factory: HomeCoordinatorFactoryProtocol) {
        self.factory = factory
        super.init()
        self.viewModel = HomeViewModelImpl()

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
