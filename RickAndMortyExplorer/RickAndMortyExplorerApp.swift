//
//  RickAndMortyExplorerApp.swift
//  RickAndMortyExplorer
//
//  Created by Kolya Stypanovych on 28/12/2023.
//

import SwiftUI
import HomeFlow

@main
struct RickAndMortyExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            HomeCoordinatorView(coordinator: HomeCoordinator(factory: HomeCoordinatorFactory()))
        }
    }
}
