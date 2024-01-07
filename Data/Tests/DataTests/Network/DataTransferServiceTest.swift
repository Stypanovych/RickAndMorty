//
//  DataTransferServiceTest.swift
//
//
//  Created by Kolya Stypanovych on 07/01/2024.
//

import XCTest
import Alamofire
@testable import Data

class DataTransferServiceTest: XCTestCase {

    func testExecuteRequestSuccess() {
        let networkingService = NetworkServiceProtocolMock()
        let sut = DataTransferService(networkService: networkingService)
        let param: MockParameter? = nil

        let cancellable = sut.request(
            path: String(),
            method: .get,
            parameters: param,
            headers: nil,
            encoding: JSONEncoding(),
            decoder: JSONDecoder(),
            encoder: JSONEncoder()
        ).sink { completion in
            guard case .failure(let error) = completion else { return }
            XCTFail("request failed: \(error.localizedDescription)")
        } receiveValue: { (_: MockParameter) in }
        cancellable.cancel()
    }

    func testExecuteRequestEncodingFailed() {
        let networkingService = NetworkServiceProtocolMock()
        let sut = DataTransferService(networkService: networkingService)
        let param: MockParameter? = MockParameter()

        let cancellable = sut.request(
            path: String(),
            method: .get,
            parameters: param,
            headers: nil,
            encoding: JSONEncoding(),
            decoder: JSONDecoder(),
            encoder: MockEncoder()
        ).sink { completion in
            guard case .failure(let error) = completion else { return }
            guard case .encoding(let encodingError) = error as? DataTransferError else {
                XCTFail("Wrong error thrown")
                return
            }
            XCTAssertEqual(encodingError.localizedDescription, TestError.mockError.localizedDescription)
        } receiveValue: { (_: MockParameter) in
            XCTFail("Encoding should fail")
        }
        cancellable.cancel()
    }

    func testExecuteRequestEmptyData() {
        let networkingService = NetworkServiceProtocolMock()
        networkingService.completionParameters = .emptyData
        let sut = DataTransferService(networkService: networkingService)
        let param: MockParameter? = nil

        let cancellable = sut.request(
            path: String(),
            method: .get,
            parameters: param,
            headers: nil,
            encoding: JSONEncoding(),
            decoder: JSONDecoder(),
            encoder: JSONEncoder()
        ).sink { completion in
            guard case .failure(let error) = completion else { return }
            guard case .noResponse = error as? DataTransferError else {
                XCTFail("Wrong error thrown")
                return
            }
        } receiveValue: { (_: MockParameter) in
            XCTFail("Encoding should fail")
        }
        cancellable.cancel()
    }

    func testExecuteRequestDecodingFailed() {
        let networkingService = NetworkServiceProtocolMock()
        networkingService.completionParameters = .data
        let sut = DataTransferService(networkService: networkingService)
        let param: MockParameter? = nil

        let cancellable = sut.request(
            path: String(),
            method: .get,
            parameters: param,
            headers: nil,
            encoding: JSONEncoding(),
            decoder: MockDecoder(),
            encoder: JSONEncoder()
        ).sink { completion in
            guard case .failure(let error) = completion else { return }
            guard case .decoding(let decodingError) = error as? DataTransferError else {
                XCTFail("Wrong error thrown")
                return
            }
            XCTAssertEqual(decodingError.localizedDescription, TestError.mockError.localizedDescription)
        } receiveValue: { (_: MockParameter) in
            XCTFail("Encoding should fail")
        }
        cancellable.cancel()
    }

    func testExecuteRequestFailed() {
        let networkingService = NetworkServiceProtocolMock()
        networkingService.completionParameters = .error
        let sut = DataTransferService(networkService: networkingService)
        let param: MockParameter? = nil

        let cancellable = sut.request(
            path: String(),
            method: .get,
            parameters: param,
            headers: nil,
            encoding: JSONEncoding(),
            decoder: MockDecoder(),
            encoder: JSONEncoder()
        ).sink { completion in
            guard case .failure(let error) = completion else { return }
            XCTAssertEqual(error.localizedDescription, TestError.mockError.localizedDescription)
        } receiveValue: { (_: MockParameter) in
            XCTFail("Encoding should fail")
        }
        cancellable.cancel()
    }
}
