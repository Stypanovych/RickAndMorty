//
//  MockEncoder.swift
//
//
//  Created by Kolya Stypanovych on 07/01/2024.
//

import XCTest
@testable import Data

class MockEncoder: JSONEncoder {
    override func encode<T>(_ value: T) throws -> Data where T : Encodable {
        throw TestError.mockError
    }
}
