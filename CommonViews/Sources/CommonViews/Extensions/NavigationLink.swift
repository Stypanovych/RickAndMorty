//
//  NavigationLink.swift
//
//
//  Created by Kolya Stypanovych on 12/01/2024.
//

import SwiftUI
import SwiftUINavigation

public extension NavigationLink {
    init<Enum, Case, WrappedDestination> (
        unwrapping enum: Binding<Enum?>,
        case casePath: AnyCasePath<Enum, Case>,
        @ViewBuilder destination: @escaping (Binding<Case>) -> WrappedDestination
    ) where Destination == WrappedDestination?, Label == EmptyView {
        self.init(
            unwrapping: `enum`.case(casePath),
            onNavigate: { _ in },
            destination: destination,
            label: {}
        )
    }
}
