//
//  CharactersSectionViewModel.swift
//  RickAndMortyExplorer
//
//  Created by Kolya Stypanovych on 29/12/2023.
//

import Foundation
import Combine
import Domain
import Common
import Data

public class CharactersSectionViewModel: ObservableObject { //named as CharactersSectionViewModel because expected to have other VMs which calls location and episodes which may have the same view but different VMs.

    public enum Result: Equatable {
        case moveBack
        case showFilter(String?, String?)
        case showDetails(Characters.CharactersResult)
    }

    public var onResult: ((Result) -> Void)?

    var hasNext: Bool = false
    @Published var characters = [Characters.CharactersResult]()
    @Published var errorDescription: String?
    @Published var searchName: String = String()
    @Published var noData = false

    init() {}

    func fetchData() {}

    func onBackButtonPressed() {}

    func onFilterPressed() {}

    func onCharacterPressed(_ character: Characters.CharactersResult) {}

    func emptyRequest() {}

    func nextPage() {}

    func setFilters(status: String?, gender: String?) {}
}

public class CharactersSectionViewModelImpl: CharactersSectionViewModel {

    private var cancellables = Set<AnyCancellable>()

    private var hasUpdate = false
    private var charactersQuery = CharactersQuery(page: 1)
    private let useCase: CharactersUseCaseProtocol

    init(useCase: CharactersUseCaseProtocol) {
        self.useCase = useCase
        super.init()

        $searchName
            .removeDuplicates()
            .throttle(for: .milliseconds(400), scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] name in
                self?.hasUpdate = true
                self?.emptyRequest()
                self?.charactersQuery.name = name.isEmpty ? nil : name
                self?.fetchData()
            }
            .store(in: &cancellables)
    }

    override func fetchData() {
        useCase.execute(charactersQuery: charactersQuery)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    if let error = error as? NetworkError,
                       case .error(let statusCode, _) = error,
                       statusCode == 404 {
                        self?.noData = true
                    } else {
                        self?.noData = false
                        self?.errorDescription = error.localizedDescription
                    }
                }
            } receiveValue: { [weak self] result in
                self?.noData = false
                if self?.hasUpdate == false {
                    self?.characters.append(contentsOf: result.results)
                } else {
                    self?.characters = result.results
                }
                self?.hasNext = result.info.next != nil
                self?.hasUpdate = false
            }
            .store(in: &cancellables)
    }

    override func onBackButtonPressed() {
        onResult?(.moveBack)
    }

    override func onFilterPressed() {
        onResult?(.showFilter(charactersQuery.status, charactersQuery.gender))
    }

    override func onCharacterPressed(_ character: Characters.CharactersResult) {
        onResult?(.showDetails(character))
    }

    override func emptyRequest() {
        charactersQuery = CharactersQuery(page: 1)
    }

    override func nextPage() {
        charactersQuery.page = ((charactersQuery.page ?? 1) + 1)
        fetchData()
    }

    override func setFilters(status: String?, gender: String?) {
        emptyRequest()
        hasUpdate = true
        charactersQuery.status = status
        charactersQuery.gender = gender
        charactersQuery.name = searchName
        fetchData()
    }
}
