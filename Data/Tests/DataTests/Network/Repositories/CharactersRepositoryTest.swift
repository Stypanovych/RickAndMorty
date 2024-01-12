//
//  CharactersRepositoryTest.swift
//
//
//  Created by Kolya Stypanovych on 12/01/2024.
//

import XCTest
import Alamofire
import Combine
import Domain
@testable import Data

class CharactersRepositoryTest: XCTestCase {

    func testGetCharactersDataSuccess() {
        let mock = DataTransferServiceProtocolMock()
        let dto = CharactersDTO(
            info: .init(
                count: 0,
                pages: 1,
                next: nil,
                prev: nil
            ), results: []
        )
        mock.data = try? JSONEncoder().encode(dto)
        let sut = CharactersRepository(dataTransferService: mock)

        let query = CharactersQuery()
        let cancellable = sut.getCharactersData(charactersQuery: query)
            .sink { completion in
                guard case .failure = completion else { return }
                XCTFail("Error should not be thrown")
            } receiveValue: { result in
                XCTAssertEqual(result.results, [])
                XCTAssertNil(result.info.next)
                XCTAssertNil(result.info.prev)
                XCTAssertEqual(result.info.count, 0)
                XCTAssertEqual(result.info.pages, 1)
            }
        cancellable.cancel()
    }
}
