//
//  View.swift
//
//
//  Created by Kolya Stypanovych on 12/01/2024.
//

import SwiftUI

public extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }

    func backgroundColor(
        _ colorName: String
    ) -> some View {
        ZStack {
            Color(colorName)
                .ignoresSafeArea()
            self
        }
    }
}
