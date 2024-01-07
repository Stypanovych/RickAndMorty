//
//  MockDecoder.swift
//
//
//  Created by Kolya Stypanovych on 07/01/2024.
//

import XCTest
@testable import Data

class MockDecoder: JSONDecoder {
    override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        throw TestError.mockError
    }
}
