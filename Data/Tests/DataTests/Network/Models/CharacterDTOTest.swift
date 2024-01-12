//
//  File.swift
//  
//
//  Created by Kolya Stypanovych on 12/01/2024.
//

import XCTest
@testable import Data

class CharactersDTOTests: XCTestCase {

    func testToDomain() {
        let charactersDTO = CharactersDTO(
            info: CharactersDTO.InfoDTO(count: 2, pages: 1, next: "next", prev: "prev"),
            results: [
                CharactersDTO.CharactersResultDTO(
                    id: 1,
                    name: "Test Character",
                    status: "Alive",
                    species: "Human",
                    type: "Test",
                    gender: "Male",
                    url: "https://example.com",
                    created: "2024-01-12",
                    episode: ["S01E01"],
                    image: "https://example.com/image.jpg",
                    origin: CharactersDTO.OriginDTO(name: "Earth", url: "https://example.com/earth"),
                    location: CharactersDTO.LocationDTO(name: "Location", url: "https://example.com/location")
                )
            ]
        )

        let characters = charactersDTO.toDomain()

        XCTAssertEqual(characters.info.count, 2)
        XCTAssertEqual(characters.info.pages, 1)
        XCTAssertEqual(characters.info.next, "next")
        XCTAssertEqual(characters.info.prev, "prev")

        XCTAssertEqual(characters.results.count, 1)
        XCTAssertEqual(characters.results[0].id, 1)
        XCTAssertEqual(characters.results[0].name, "Test Character")
        XCTAssertEqual(characters.results[0].status, "Alive")
        XCTAssertEqual(characters.results[0].species, "Human")
        XCTAssertEqual(characters.results[0].type, "Test")
        XCTAssertEqual(characters.results[0].gender, "Male")
        XCTAssertEqual(characters.results[0].url, "https://example.com")
        XCTAssertEqual(characters.results[0].created, "2024-01-12")
        XCTAssertEqual(characters.results[0].episode, ["S01E01"])
        XCTAssertEqual(characters.results[0].image, "https://example.com/image.jpg")
        XCTAssertEqual(characters.results[0].origin.name, "Earth")
        XCTAssertEqual(characters.results[0].origin.url, "https://example.com/earth")
        XCTAssertEqual(characters.results[0].location.name, "Location")
        XCTAssertEqual(characters.results[0].location.url, "https://example.com/location")
    }
}
