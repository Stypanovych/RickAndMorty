//
//  SectionDetailsCoordinatorView.swift
//  RickAndMortyExplorer
//
//  Created by Kolya Stypanovych on 02/01/2024.
//

import SwiftUI
import SwiftUINavigation
import CommonViews

struct SectionDetailsCoordinatorView: View {
    
    @ObservedObject var coordinator: SectionDetailsCoordinator
    
    var body: some View {
        NavigationView {
            ZStack {
                SectionDetailsView(
                    viewModel: coordinator.viewModel
                )

                NavigationLink(
                    unwrapping: $coordinator.route,
                    case: /SectionDetailsCoordinator.Route.details
                ) { (coordinator: Binding<DetailsCoordinator>) in
                    DetailsCoordinatorView(coordinator: coordinator.wrappedValue)
                }

                NavigationLink(
                    unwrapping: $coordinator.route,
                    case: /SectionDetailsCoordinator.Route.filter
                ) { (coordinator: Binding<FilterCoordinator>) in
                    FilterCoordinatorView(coordinator: coordinator.wrappedValue)
                }
            }
        }
        .navigationBarHidden(true)
    }
}
