//
//  SectionInfo.swift
//  RickAndMortyExplorer
//
//  Created by Kolya Stypanovych on 03/01/2024.
//

import Foundation

public enum SectionInfo: String, Identifiable, CaseIterable {

    case locations
    case episodes
    case characters

    public var id: String {
        self.rawValue
    }

    public var title: String {
        switch self {
        case .episodes: return "Characters"
        case .locations: return "Locations"
        case .characters: return "Episodes"
        }
    }

    public var imageName: String {
        switch self {
        case .episodes: return "charactersImage"
        case .locations: return "locationsImage"
        case .characters: return "episodesImage"
        }
    }
}
