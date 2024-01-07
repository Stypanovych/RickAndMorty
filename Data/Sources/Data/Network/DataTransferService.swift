//
//  DataTransferService.swift
//
//
//  Created by Kolya Stypanovych on 28/12/2023.
//

import Foundation
import Alamofire
import Combine
import InfoLogger

enum DataTransferError: Error {
    case noResponse
    case decoding(Error)
    case encoding(Error)
}

public protocol DataTransferServiceProtocol {
    func request<T: Codable, P: Encodable>(
        path: String,
        method: HTTPMethod,
        parameters: P?,
        headers: HTTPHeaders?,
        encoding: ParameterEncoding,
        decoder: JSONDecoder,
        encoder: JSONEncoder
    ) -> AnyPublisher<T, Error>
}

public class DataTransferService: DataTransferServiceProtocol {

    private let networkService: NetworkServiceProtocol

    public init(
        networkService: NetworkServiceProtocol
    ) {
        self.networkService = networkService
    }

    public func request<T: Codable, P: Encodable>(
        path: String,
        method: HTTPMethod,
        parameters: P?,
        headers: HTTPHeaders?,
        encoding: ParameterEncoding,
        decoder: JSONDecoder,
        encoder: JSONEncoder
    ) -> AnyPublisher<T, Error> {
        return Future<T, Error> { [weak self] promise in
            do {
                var params: [String: Any]? = nil
                if let parameters = parameters {
                    params  = try self?.encodeToDictionary(encoder: encoder, parameters: parameters)
                }
                self?.networkService.executeRequest(
                    path: path,
                    method: method,
                    parameters: params,
                    headers: headers,
                    encoding: encoding
                ) { [weak self] result in
                    self?.handle(dataResponse: result, decoder: decoder, completion: promise)
                }
            } catch {
                InfoLogger.log(.error, error.localizedDescription)
                promise(.failure(DataTransferError.encoding(error)))
            }
        }
        .eraseToAnyPublisher()
    }

    private func handle<T: Codable>(
        dataResponse: Result<Data?, Error>,
        decoder: JSONDecoder,
        completion: @escaping (Result<T, Error>) -> Void
    )  {
        switch dataResponse {
        case .success(let data):
            guard let data else {
                let error: DataTransferError = .noResponse
                InfoLogger.log(.error, error.localizedDescription)
                completion(.failure(error))
                return
            }
            do {
                let expectedValue = try decoder.decode(T.self, from: data)
                completion(.success(expectedValue))
            } catch {
                InfoLogger.log(.error, error.localizedDescription)
                completion(.failure(DataTransferError.decoding(error)))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }

    private func encodeToDictionary<P: Encodable>(encoder: JSONEncoder, parameters: P?) throws -> [String: Any]? {
        let data = try encoder.encode(parameters)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String : Any]
    }
}
