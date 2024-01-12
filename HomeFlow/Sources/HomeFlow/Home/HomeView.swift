//
//  HomeView.swift
//  RickAndMortyExplorer
//
//  Created by Kolya Stypanovych on 28/12/2023.
//

import SwiftUI
import Domain
import CommonViews

struct HomeView: View {

    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(SectionInfo.allCases) { section in
                SectionView(imageName: section.imageName, title: section.title)
                    .onTapGesture {
                        viewModel.onSelect(section: section)
                    }
            }
            .padding(.all, 24)
        }
        .backgroundColor("BackgroundColor")
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Choose section")
    }
}


