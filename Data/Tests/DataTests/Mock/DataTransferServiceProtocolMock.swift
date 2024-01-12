//
//  DataTransferServiceProtocolMock.swift
//
//
//  Created by Kolya Stypanovych on 12/01/2024.
//

import XCTest
import Alamofire
import Combine
@testable import Data

class DataTransferServiceProtocolMock: DataTransferServiceProtocol {
    var data: Data?
    func request<T, P>(
        path: String,
        method: HTTPMethod,
        parameters: P?,
        headers: HTTPHeaders?,
        encoding: ParameterEncoding,
        decoder: JSONDecoder,
        encoder: JSONEncoder
    ) -> AnyPublisher<T, Error> where T : Decodable, T : Encodable, P : Encodable {
        return Future<T, Error> { promise in
            promise(.success(try! decoder.decode(T.self, from: self.data!)))
        }
        .eraseToAnyPublisher()
    }
}
