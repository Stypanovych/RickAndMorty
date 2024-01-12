import XCTest
@testable import Domain

class CharactersUseCaseTests: XCTestCase {

    func testGetExchangeDataSuccess() {
        let sut = CharactersUseCase(charactersRepository: CharactersRepositoryProtocolMock())

        let query = CharactersQuery()

        let cancellable = sut.execute(charactersQuery: query)
            .sink { completion in
                guard case .failure = completion else { return }
                XCTFail("Error should not be thrown")
            } receiveValue: { result in
                XCTAssertEqual(result.info.count, 0)
                XCTAssertEqual(result.info.pages, 1)
                XCTAssertNil(result.info.next)
                XCTAssertNil(result.info.prev)
            }
        cancellable.cancel()
    }
}
