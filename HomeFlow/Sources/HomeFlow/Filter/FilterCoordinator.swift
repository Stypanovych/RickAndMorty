//
//  FilterCoordinator.swift
//
//
//  Created by Kolya Stypanovych on 06/01/2024.
//

import Foundation
import Common

public class FilterCoordinator: Coordinator {

    public enum Route {}

    @Published public var route: Route?

    enum Result: Equatable {
        case moveBack
        case applyFilters(String?, String?)
    }

    var onResult: ((Result) -> Void)?
    let viewModel: FilterViewModel

    init(
        status: String?,
        gender: String?,
        factory: HomeCoordinatorFactoryProtocol
    ) {
        let viewModel = factory.makeFilterViewModel(status: status, gender: gender)
        self.viewModel = viewModel
    }
}

public class FilterCoordinatorImpl: FilterCoordinator {

    override init(status: String?, gender: String?, factory: HomeCoordinatorFactoryProtocol) {
        super.init(status: status, gender: gender, factory: factory)

        viewModel.onResult = { [weak self] result in
            switch result {
            case .moveBack:
                self?.onResult?(.moveBack)
            case .applyFilter(let status, let gender):
                self?.onResult?(.applyFilters(status, gender))
            }
        }
    }
}
