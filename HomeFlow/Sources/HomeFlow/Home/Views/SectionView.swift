//
//  SectionView.swift
//
//
//  Created by Kolya Stypanovych on 04/01/2024.
//

import SwiftUI

struct SectionView: View {

    let imageName: String
    let title: String
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
            Color.white.opacity(0.5)
            Text(title)
                .font(.system(size: 20, weight: .semibold))
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
