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
    let viewModel: DetailsViewModel

    private let factory: HomeCoordinatorFactory

    init(
        factory: HomeCoordinatorFactory,
        character: Characters.CharactersResult
    ) {
        self.factory = factory

        let viewModel = factory.makeDetailsViewModel(character: character)
        self.viewModel = viewModel

        viewModel.onResult = { [weak self] result in
            switch result {
            case .moveBack:
                self?.onResult?(.moveBack)
            }
        }
    }
}
