//
//  CharactersUseCaseMock.swift
//
//
//  Created by Kolya Stypanovych on 12/01/2024.
//

import XCTest
import Combine
import Domain
@testable import HomeFlow

class CharactersUseCaseMock: CharactersUseCaseProtocol {

    enum Response {
        case success(Characters)
        case error(Error)
    }

    var response: Response?

    func execute(charactersQuery: CharactersQuery?) -> AnyPublisher<Characters, Error> {
        return Future<Characters, Error> { promise in
            switch self.response {
            case .success(let info):
                promise(.success(info))
            case .error(let error):
                promise(.failure(error))
            case .none:
                break
            }
        }
        .eraseToAnyPublisher()
    }
}
