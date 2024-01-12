//
//  DetailsCoordinator.swift
//
//
//  Created by Kolya Stypanovych on 05/01/2024.
//

import Foundation
import Common
import Domain

public class DetailsCoordinator: Coordinator {

    public enum Route {}

    @Published public var route: Route?

    enum Result: Equatable {
        case moveBack
    }

    var onResult: ((Result) -> Void)?
    var viewModel: DetailsViewModel

    init(character: Characters.CharactersResult) {

        let viewModel = DetailsViewModel(character: character)
        self.viewModel = viewModel
    }
}

public class DetailsCoordinatorImpl: DetailsCoordinator {

    private let factory: HomeCoordinatorFactoryProtocol

    init(
        factory: HomeCoordinatorFactoryProtocol,
        character: Characters.CharactersResult
    ) {
        self.factory = factory
        super.init(character: character)
        viewModel = factory.makeDetailsViewModel(character: character)

        viewModel.onResult = { [weak self] result in
            switch result {
            case .moveBack:
                self?.onResult?(.moveBack)
            }
        }
    }
}
