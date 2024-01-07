//
//  CharactersUseCase.swift
//
//
//  Created by Kolya Stypanovych on 03/01/2024.
//

import Foundation
import Combine

public protocol CharactersUseCaseProtocol {
    func execute(
        charactersQuery: CharactersQuery?
    ) -> AnyPublisher<Characters, Error>
}

public final class CharactersUseCase: CharactersUseCaseProtocol {

    private let charactersRepository: CharactersRepositoryProtocol

    public init(
        charactersRepository: CharactersRepositoryProtocol
    ) {

        self.charactersRepository = charactersRepository
    }

    public func execute(
        charactersQuery: CharactersQuery?
    ) -> AnyPublisher<Characters, Error> {
        return charactersRepository.getCharactersData(charactersQuery: charactersQuery)
    }
}
