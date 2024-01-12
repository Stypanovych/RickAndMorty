//
//  SectionDetailsView.swift
//  RickAndMortyExplorer
//
//  Created by Kolya Stypanovych on 29/12/2023.
//

import SwiftUI
import Domain
import CommonViews
import SDWebImageSwiftUI

struct SectionDetailsView: View {

    @ObservedObject var viewModel: CharactersSectionViewModel
    @State var showSearchBar = true

    let columns: [GridItem] = [
        .init(.flexible(), spacing: 24),
        .init(.flexible(), spacing: 24)
    ]

    var body: some View {
        Group {
            contentView
        }
        .backgroundColor("BackgroundColor")
        .alert(
            isPresented: Binding<Bool>(
                get: {
                    return viewModel.errorDescription != nil
                },
                set: { newValue in
                    if newValue {
                        withAnimation {
                            viewModel.errorDescription = nil
                        }
                    }
                }
            )
        ) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorDescription ?? String()),
                dismissButton: .default(
                    Text("Okay"),
                    action: {
                        viewModel.errorDescription = nil
                    }
                )
            )
        }
        .navigationBarItems(leading: backButton, trailing: filterButton)
        .navigationTitle("Characters")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }

    var contentView: some View {
        VStack {
            SearchBar(placeholder: "Enter a name", text: $viewModel.searchName)
                .frame(height: showSearchBar ? 40 : 0)
                .background(Color("BrightGray"))
                .cornerRadius(7)
                .padding(.horizontal, 24)
                .padding(.top, 4)
            if viewModel.noData {
                NoDataView()
            } else {
                itemsView
            }
        }
    }

    var itemsView: some View {
        Group {
            if !viewModel.characters.isEmpty {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(viewModel.characters, id: \.id) { character in
                            createGridItem(characterInfo: character)
                        }
                    }
                    .padding(.horizontal, 24)
                    loadMoreView
                }
            } else {
                Spacer()
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

    var filterButton: some View {
        Button {
            viewModel.onFilterPressed()
        } label: {
            Image("filter")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
    }

    func createGridItem(characterInfo: Characters.CharactersResult) -> some View {
        Button(action: {
            viewModel.onCharacterPressed(characterInfo)
        }, label: {
            ZStack {
                WebImage(url: URL(string: characterInfo.image))
                    .resizable()
                    .placeholder {
                        ZStack {
                            Color.white
                        }
                    }
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                VStack {
                    Spacer()
                        .frame(maxHeight: .infinity)
                    Text(characterInfo.name)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.all, 5)
                        .background(
                            Color.white.opacity(0.5)
                        )
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
        })
    }

    var loadMoreView: some View {
        LazyVStack {
            if viewModel.hasNext {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .scaleEffect(1.5)
                    .padding()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            viewModel.nextPage()
                        }
                    }
            }
        }
    }
}
