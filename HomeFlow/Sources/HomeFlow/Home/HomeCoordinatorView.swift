//
//  HomeCoordinatorView.swift
//  RickAndMortyExplorer
//
//  Created by Kolya Stypanovych on 29/12/2023.
//

import SwiftUI
import SwiftUINavigation

public struct HomeCoordinatorView: View {

    @ObservedObject var coordinator: HomeCoordinator

    public init(coordinator: HomeCoordinator) {
        _coordinator = ObservedObject(wrappedValue: coordinator)

        UINavigationBar
            .appearance()
            .titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .foregroundColor: UIColor(Color("TextColor"))
            ]
        UINavigationBar.appearance()
            .barTintColor = UIColor(Color("BackgroundColor"))
    }

    public var body: some View {
        NavigationView {
            ZStack {
                HomeView(
                    viewModel: coordinator.viewModel
                )

                NavigationLink(
                    unwrapping: $coordinator.route,
                    case: /HomeCoordinator.Route.sectionDetails
                ) { (coordinator: Binding<SectionDetailsCoordinator>) in
                    SectionDetailsCoordinatorView(coordinator: coordinator.wrappedValue)
                }
            }
        }
    }
}
