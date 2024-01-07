//
//  DetailsView.swift
//  
//
//  Created by Kolya Stypanovych on 05/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {
    @ObservedObject var viewModel: DetailsViewModel

    var body: some View {
        Group {
            VStack(spacing: 16) {
                WebImage(url: URL(string: viewModel.character.image))
                    .resizable()
                    .placeholder(content: {
                        Color.white
                    })
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.bottom, 12)

                CharacterInfoView(labelTitle: "Name:", info: viewModel.character.name)
                CharacterInfoView(labelTitle: "Status:", info: viewModel.character.status)
                CharacterInfoView(labelTitle: "Species:", info: viewModel.character.species)
                CharacterInfoView(labelTitle: "Gender:", info: viewModel.character.gender)
                Spacer()
            }
            .padding(24)
        }
        .backgroundColor("BackgroundColor")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
    }

    var backButton: some View {
        Button {
            viewModel.onBackButtonPressed()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(Color("TextColor"))
        }
    }
}

struct CharacterInfoView: View {
    let labelTitle: String
    let info: String

    var body: some View {
        HStack {
            Text(labelTitle)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color("TextColor"))
            Text(info)
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(.white)
                .padding(.leading, 12)
            Spacer()
        }
    }
}
