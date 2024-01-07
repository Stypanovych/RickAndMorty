//
//  Characters.swift
//
//
//  Created by Kolya Stypanovych on 03/01/2024.
//

import Foundation

public struct Characters: Equatable {
    public let info: Info
    public let results: [CharactersResult]

    public init(info: Info, results: [CharactersResult]) {
        self.info = info
        self.results = results
    }

    public struct Info: Equatable {
        public let count: Int
        public let pages: Int
        public let next: String?
        public let prev: String?

        public init(count: Int, pages: Int, next: String?, prev: String?) {
            self.count = count
            self.pages = pages
            self.next = next
            self.prev = prev
        }
    }

    public struct CharactersResult: Equatable {
        public let id: Int
        public let name: String
        public let status: String
        public let species: String
        public let type: String
        public let gender: String
        public let url: String
        public let created: String
        public let episode: [String]
        public let image: String
        public let origin: Origin
        public let location: Location

        public init(
            id: Int,
            name: String,
            status: String,
            species: String,
            type: String,
            gender: String,
            url: String,
            created: String,
            episode: [String],
            image: String,
            origin: Origin,
            location: Location
        ) {
            self.id = id
            self.name = name
            self.status = status
            self.species = species
            self.type = type
            self.gender = gender
            self.url = url
            self.created = created
            self.episode = episode
            self.image = image
            self.origin = origin
            self.location = location
        }
    }
    public struct Origin: Equatable {
        public let name: String
        public let url: String

        public init(name: String, url: String) {
            self.name = name
            self.url = url
        }
    }
    public struct Location: Equatable {
        public let name: String
        public let url: String

        public init(name: String, url: String) {
            self.name = name
            self.url = url
        }
    }
}
