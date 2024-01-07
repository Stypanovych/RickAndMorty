//
//  Resultable.swift
//  RickAndMortyExplorer
//
//  Created by Kolya Stypanovych on 29/12/2023.
//

import Foundation

public protocol Resultable: ObservableObject {

    associatedtype Result: Equatable

    var onResult: ((Result) -> Void)? { get set }
}
