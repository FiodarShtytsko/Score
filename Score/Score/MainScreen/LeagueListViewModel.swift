//
//  LeagueListViewModel.swift
//  Score
//
//  Created by Fiodar Shtytsko on 22/03/2025.
//

import Combine

@MainActor
final class LeagueListViewModel: ObservableObject {
    @Published var leagues: [League] = []
    @Published var isLoading = true
    @Published var errorMessage: String?

    private let fetchLeaguesUseCase: FetchLeaguesUseCase

    init(fetchLeaguesUseCase: FetchLeaguesUseCase) {
        self.fetchLeaguesUseCase = fetchLeaguesUseCase
    }

    func loadLeagues() async {
        isLoading = true
        errorMessage = nil

        let result = await fetchLeaguesUseCase.execute()

        switch result {
        case .success(let leagues):
            self.leagues = leagues
        case .failure(let error):
            self.errorMessage = "Failed to load leagues: \(error.localizedDescription)"
        }

        isLoading = false
    }
}

