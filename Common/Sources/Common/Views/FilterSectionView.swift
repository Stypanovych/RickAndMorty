//
//  FilterSectionView.swift
//  
//
//  Created by Kolya Stypanovych on 07/01/2024.
//

import SwiftUI

public protocol FilterEnumProtocol {
    var title: String { get }
}

public struct FilterSectionView<Item: Identifiable & Equatable & FilterEnumProtocol>: View {
    let title: String
    @Binding var selectedValue: Item?
    var resetAction: () -> Void
    var items: [Item]
    var selectAction: (Item) -> Void

    public init(title: String, 
         selectedValue: Binding<Item?>,
         resetAction: @escaping () -> Void,
         items: [Item],
         selectAction: @escaping (Item) -> Void
    ) {
        self.title = title
        self._selectedValue = selectedValue
        self.resetAction = resetAction
        self.items = items
        self.selectAction = selectAction
    }

    public var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("TextColor"))
                Spacer()
                Text("Reset")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("CranberryColor"))
                    .opacity(selectedValue == nil ? 0.5 : 1)
                    .onTapGesture {
                        resetAction()
                    }

            }
            .padding(.bottom, 24)
            ForEach(items, id: \.id) { item in
                Button {
                    selectAction(item)
                } label: {
                    HStack {
                        Circle().frame(width: 20)
                        Text("\(item.title)")
                            .font(.system(size: 18, weight: .regular))
                            .padding(.leading, 12)
                        Spacer()
                    }
                    .foregroundColor(item == selectedValue ? Color("TextColor") : .white)
                }
            }
        }
    }
}
