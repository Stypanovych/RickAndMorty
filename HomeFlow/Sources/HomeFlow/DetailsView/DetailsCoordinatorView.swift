//
//  DetailsCoordinatorView.swift
//
//
//  Created by Kolya Stypanovych on 05/01/2024.
//

import SwiftUI
import SwiftUINavigation

struct DetailsCoordinatorView: View {

    @ObservedObject var coordinator: DetailsCoordinator

    var body: some View {
        ZStack {
            DetailsView(
                viewModel: coordinator.viewModel
            )
        }
    }
}
