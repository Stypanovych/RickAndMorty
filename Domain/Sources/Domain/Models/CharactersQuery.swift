//
//  CharactersQuery.swift
//
//
//  Created by Kolya Stypanovych on 03/01/2024.
//

import Foundation

public struct CharactersQuery: Encodable {
    public var page: Int?
    public var name: String?
    public var status: String?
    public var gender: String?

    public init(
        page: Int? = nil,
        name: String? = nil,
        status: String? = nil,
        gender: String? = nil
    ) {
        self.page = page
        self.name = name
        self.status = status
        self.gender = gender
    }
}
