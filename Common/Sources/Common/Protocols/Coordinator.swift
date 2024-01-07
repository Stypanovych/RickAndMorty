//
//  Coordinator.swift
//  RickAndMortyExplorer
//
//  Created by Kolya Stypanovych on 29/12/2023.
//

import Foundation

public protocol Coordinator: ObservableObject {

    associatedtype Route

    var route: Route? { get set }
}
