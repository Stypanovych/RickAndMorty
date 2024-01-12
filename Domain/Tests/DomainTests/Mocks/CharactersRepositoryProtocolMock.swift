//
//  CharactersRepositoryProtocolMock.swift
//
//
//  Created by Kolya Stypanovych on 12/01/2024.
//

import XCTest
import Combine
@testable import Domain

class CharactersRepositoryProtocolMock: CharactersRepositoryProtocol {
    func getCharactersData(charactersQuery: CharactersQuery?) -> AnyPublisher<Domain.Characters, Error> {
        return Future<Characters, Error> { promise in
            let info = Characters(
                info: .init(
                    count: 0,
                    pages: 1,
                    next: nil,
                    prev: nil
                ),
                results: []
            )
            promise(.success(info))
        }
        .eraseToAnyPublisher()
    }
}
