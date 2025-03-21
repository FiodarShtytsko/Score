//
//  MatchListView.swift
//  Score
//
//  Created by Fiodar Shtytsko on 21/03/2025.
//

import SwiftUI

struct LeagueListView: View {
    @State var league: [League] = mockLeagues

    var body: some View {
        NavigationView {
            List {
                ForEach(league, id: \.id) { league in
                    LeagueCellView(league: league)
                }
            }
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
