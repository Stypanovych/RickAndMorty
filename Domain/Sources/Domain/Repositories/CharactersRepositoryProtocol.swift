//
//  CharactersRepositoryProtocol.swift
//
//
//  Created by Kolya Stypanovych on 03/01/2024.
//

import Foundation
import Combine

public protocol CharactersRepositoryProtocol {
    func getCharactersData(
        charactersQuery: CharactersQuery?
    ) -> AnyPublisher<Characters, Error>
}

