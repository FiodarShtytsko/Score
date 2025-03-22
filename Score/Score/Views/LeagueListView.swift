//
//  MatchListView.swift
//  Score
//
//  Created by Fiodar Shtytsko on 21/03/2025.
//

import SwiftUI

struct LeagueListView: View {
    @State var leagues: [League] = []
    @State private var isLoading = true

    var body: some View {
        NavigationView {
            List {
                if isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    ForEach(leagues, id: \.id) { league in
                        LeagueCellView(league: league)
                    }
                }
            }
            .navigationTitle("Leagues")
            .task {
                await loadLeagues()
            }
        }
    }


    private func loadLeagues() async {
        do {
            let url = URL(string:"https://growthprodeus2.prod-cdn.clipro.tv/tests/mobile-task/games.json")!
            let result = try await APIService.fetchLeagues(from: url)

            await MainActor.run {
                self.leagues = result
                self.isLoading = false
            }
        } catch {
            print("Ошибка загрузки: \(error)")
            isLoading = false
        }
    }
}

// MARK: - Mock Data
#if DEBUG
let mockLeagues: [League] = [
    League(
        id: "1",
        name: "Premier League",
        imageURL: URL(string: "https://media-3.api-sports.io/football/leagues/383.png")!,
        matches: []
    ),
    League(
        id: "2",
        name: "La Liga",
        imageURL: URL(string: "https://media.api-sports.io/flags/it.svg")!,
        matches: mockMatches
    )
]
#endif
