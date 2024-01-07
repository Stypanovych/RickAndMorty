//
//  DetailsViewModel.swift
//  
//
//  Created by Kolya Stypanovych on 05/01/2024.
//

import Foundation
import Domain

public class DetailsViewModel: ObservableObject {
    
    public enum Result: Equatable {
        case moveBack
    }

    public var onResult: ((Result) -> Void)?

    let character: Characters.CharactersResult

    init(character: Characters.CharactersResult) {
        self.character = character
    }

    func onBackButtonPressed() {
        onResult?(.moveBack)
    }
}
