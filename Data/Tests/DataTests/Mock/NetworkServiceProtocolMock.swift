//
//  NetworkServiceProtocolMock.swift
//
//
//  Created by Kolya Stypanovych on 07/01/2024.
//

import XCTest
import Alamofire
@testable import Data

class NetworkServiceProtocolMock: NetworkServiceProtocol {

    enum CompletionParameters {
        case data
        case emptyData
        case error
    }

    var completionParameters: CompletionParameters = .data

    func executeRequest(
        path: String,
        method: HTTPMethod,
        parameters: Parameters?,
        headers: HTTPHeaders?,
        encoding: ParameterEncoding,
        completion: @escaping (Result<Data?, Error>) -> Void
    ) {
        switch completionParameters {
        case .data:
            let data = try? JSONEncoder().encode(MockParameter())
            completion(.success(data))
        case .emptyData:
            completion(.success(nil))
        case .error:
            completion(.failure(TestError.mockError))
        }
    }
}
