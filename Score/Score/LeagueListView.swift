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

struct LeagueCellView: View {

    let league: League

    var body: some View {
        HStack {
            Image(uiImage: .actions)
                .frame(width: 25, height: 25)
            Text(league.name)
                .bold()
            Spacer()
            Image(uiImage: .checkmark)
        }
    }
}

struct League {
    let id: String
    let name: String
    let imageURL: URL
    let matches: [Match]
}

struct Match {
}

// MARK: - Mock Data

#if DEBUG
let mockLeagues: [League] = [
    League(
        id: "1",
        name: "Premier League",
        imageURL: URL(string: "https://via.placeholder.com/48")!,
        matches: []
    ),
    League(
        id: "2",
        name: "La Liga",
        imageURL: URL(string: "https://via.placeholder.com/48")!,
        matches: []
    )
]
#endif
