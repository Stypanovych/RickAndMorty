//
//  FilterCoordinatorView.swift
//
//
//  Created by Kolya Stypanovych on 06/01/2024.
//

import SwiftUI

struct FilterCoordinatorView: View {

    @ObservedObject var coordinator: FilterCoordinator

    var body: some View {
        ZStack {
            FilterView(
                viewModel: coordinator.viewModel
            )
        }
    }
}
