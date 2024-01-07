//
//  NetworkService.swift
//  
//
//  Created by Kolya Stypanovych on 28/12/2023.
//

import Foundation
import Alamofire
import Combine
import InfoLogger

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case somethingWentWrong
}

public protocol NetworkServiceProtocol {
    func executeRequest(
        path: String,
        method: HTTPMethod,
        parameters: Parameters?,
        headers: HTTPHeaders?,
        encoding: ParameterEncoding,
        completion: @escaping (Result<Data?, Error>) -> Void
    )
}

public class NetworkService: NetworkServiceProtocol {

    private let network: Session = Session()
    let baseURLString: String

    public init(baseURLString: String) {
        self.baseURLString = baseURLString
    }

    public func executeRequest(
        path: String,
        method: HTTPMethod,
        parameters: Parameters?,
        headers: HTTPHeaders?,
        encoding: ParameterEncoding,
        completion: @escaping (Result<Data?, Error>) -> Void
    ) {
        let urlString = self.baseURLString + path

        network.request(
            urlString,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        ).responseData { [weak self] result in
            guard let self else { return }
            if (result.response?.statusCode ?? 0) > 300 || (result.response?.statusCode ?? 0) < 200 {
                var error: NetworkError
                if let response = result.response {
                    error = .error(statusCode: response.statusCode, data: result.data)
                } else {
                    if let requestError = result.error {
                        error = self.handleNetworkError(requestError)
                    } else {
                        error = .somethingWentWrong
                    }
                }
                InfoLogger.log(.error, error)
                completion(.failure(error))
            } else {
                InfoLogger.log(.info, result)
                completion(.success(result.value))
            }
        }
    }

    private func handleNetworkError(_ error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
}
