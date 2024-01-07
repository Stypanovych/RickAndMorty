//
//  SearchBar.swift
//
//
//  Created by Kolya Stypanovych on 07/01/2024.
//

import SwiftUI

public struct SearchBar: View {
    let placeholder: String

    @Binding var text: String

    public init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }

    public var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("SuvaGrey"))
                .padding(4)
            TextField(String(), text: $text)
                .placeholder(when: text.isEmpty) {
                    Text("Enter a name")
                        .foregroundColor(Color("SuvaGrey"))
                }
                .foregroundColor(.white)
            if text != "" {
                Button {
                    self.text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.medium)
                        .foregroundColor(Color("SuvaGrey"))
                        .padding(4)
                }
            }
        }
    }
}
