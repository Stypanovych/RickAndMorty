//
//  CharactersDTO.swift
//
//
//  Created by Kolya Stypanovych on 03/01/2024.
//

import Foundation
import Domain

struct CharactersDTO: Codable {
    let info: InfoDTO
    let results: [CharactersResultDTO]

    struct InfoDTO: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    struct CharactersResultDTO: Codable {
        let id: Int
        let name: String
        let status: String
        let species: String
        let type: String
        let gender: String
        let url: String
        let created: String
        let episode: [String]
        let image: String
        let origin: OriginDTO
        let location: LocationDTO
    }
    struct OriginDTO: Codable {
        let name: String
        let url: String
    }
    struct LocationDTO: Codable {
        let name: String
        let url: String
    }
}

extension CharactersDTO {
    func toDomain() -> Characters {
        .init(
            info: info.toDomain(),
            results: results.toDomain()
        )
    }
}

extension CharactersDTO.InfoDTO {
    func toDomain() -> Characters.Info {
        .init(
            count: count,
            pages: pages,
            next: next,
            prev: prev
        )
    }
}

extension CharactersDTO.OriginDTO {
    func toDomain() -> Characters.Origin {
        .init(name: name, url: url)
    }
}

extension CharactersDTO.LocationDTO {
    func toDomain() -> Characters.Location {
        .init(name: name, url: url)
    }
}

extension Array where Element == CharactersDTO.CharactersResultDTO  {
    func toDomain() -> [Characters.CharactersResult] {
        self.map {
            Characters.CharactersResult(
                id: $0.id,
                name: $0.name,
                status: $0.status,
                species: $0.species,
                type: $0.type,
                gender: $0.gender,
                url: $0.url,
                created: $0.created,
                episode: $0.episode,
                image: $0.image,
                origin: $0.origin.toDomain(),
                location: $0.location.toDomain()
            )
        }
    }
}

