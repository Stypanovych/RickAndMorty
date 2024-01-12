//
//  CharactersRepository.swift
//
//
//  Created by Kolya Stypanovych on 03/01/2024.
//

import Foundation
import Combine
import Alamofire
import Domain

public final class CharactersRepository: CharactersRepositoryProtocol {

    private let dataTransferService: DataTransferServiceProtocol

    public init(
        dataTransferService: DataTransferServiceProtocol
    ) {
        self.dataTransferService = dataTransferService
    }

    public func getCharactersData(charactersQuery: CharactersQuery?) -> AnyPublisher<Characters, Error> {
        func request() -> AnyPublisher<CharactersDTO, Error> {
            return dataTransferService.request(
                path: "character",
                method: .get,
                parameters: charactersQuery,
                headers: nil,
                encoding: URLEncoding.queryString,
                decoder: JSONDecoder(),
                encoder: JSONEncoder()
            )
        }

        return request()
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
