//
//  FilterView.swift
//
//
//  Created by Kolya Stypanovych on 06/01/2024.
//

import SwiftUI
import CommonViews

struct FilterView: View {
    @ObservedObject var viewModel: FilterViewModel

    var body: some View {
        Group {
            VStack(spacing: 16) {
                FilterSectionView(
                    title: "Status",
                    selectedValue: $viewModel.selectedStatus,
                    resetAction: viewModel.resetStatus,
                    items: FilterViewModel.Status.allCases,
                    selectAction: viewModel.selectStatus
                )

                FilterSectionView(
                    title: "Gender",
                    selectedValue: $viewModel.selectedGender,
                    resetAction: viewModel.resetGender,
                    items: FilterViewModel.Gender.allCases,
                    selectAction: viewModel.selectGender
                )

                Spacer()

                Button {
                    viewModel.onApplyFilterTapped()
                } label: {
                    Text("Apply filters")
                        .font(.system(size: 18, weight: .semibold))
                        .padding()
                        .foregroundColor(Color("TextColor"))
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color("TextColor"), lineWidth: 1)
                        )
                }
            }
            .padding(24)
        }
        .backgroundColor("BackgroundColor")
        .navigationBarTitle("Filter", displayMode: .inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: backButton)
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
