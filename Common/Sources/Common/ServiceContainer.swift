//
//  ServiceContainer.swift
//  
//
//  Created by Kolya Stypanovych on 04/01/2024.
//

import Foundation
import Domain
import Data

public class ServiceContainer {

    public static let shared = ServiceContainer()

    public lazy var networkService: NetworkServiceProtocol = NetworkService(baseURLString: Constants.baseURL)
    public lazy var dataTransferService: DataTransferServiceProtocol = DataTransferService(networkService: networkService)
    public lazy var characterRepository: CharactersRepositoryProtocol = CharactersRepository(dataTransferService: dataTransferService)
    public lazy var characterUseCase: CharactersUseCaseProtocol = CharactersUseCase(charactersRepository: characterRepository)
}
