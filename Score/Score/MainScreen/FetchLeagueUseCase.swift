//
//  FetchLeagueUseCase.swift
//  Score
//
//  Created by Fiodar Shtytsko on 22/03/2025.
//

import Foundation

protocol FetchLeaguesUseCase {
    func execute() async -> Result<[League], Error>
}


final class DefaultFetchLeaguesUseCase: FetchLeaguesUseCase {
    enum FetchLeaguesError: Error, LocalizedError {
        case invalidURL

        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "The leagues API URL is invalid."
            }
        }
    }

    private let service: APIServiceProtocol

    init(service: APIServiceProtocol) {
        self.service = service
    }

    func execute() async -> Result<[League], Error> {
        guard let url = URL(string: "https://growthprodeus2.prod-cdn.clipro.tv/tests/mobile-task/games.json") else {
            return .failure(FetchLeaguesError.invalidURL)
        }

        do {
            let leagues = try await service.fetchLeagues(from: url)
            return .success(leagues)
        } catch {
            return .failure(error)
        }
    }
}
