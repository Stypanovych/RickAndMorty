//
//  NoDataView.swift
//
//
//  Created by Kolya Stypanovych on 07/01/2024.
//

import SwiftUI

public struct NoDataView: View {

    public init() {}
    
    public var body: some View {
        VStack {
            Spacer()
            Image("rick_morty_nothing")
                .resizable()
                .scaledToFit()
            Text("Look, Morty!\nThere's nothing there!")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color("TextColor"))
                .multilineTextAlignment(.center)
                .padding(.top, 16)
            Spacer()
        }
        .padding(24)
    }
}
