//
//  MatchListView.swift
//  Score
//
//  Created by Fiodar Shtytsko on 21/03/2025.
//

import SwiftUI

struct LeagueListView: View {
    @StateObject var viewModel: LeagueListViewModel

    var body: some View {
        NavigationView {
            List {
                if viewModel.isLoading {
                    ProgressView("Loading Leagues...")
                        .frame(maxWidth: .infinity, alignment: .center)
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    ForEach(viewModel.leagues, id: \.id) { league in
                        LeagueCellView(league: league)
                    }
                }
            }
            .navigationTitle("Leagues")
            .task {
                await viewModel.loadLeagues()
            }
        }
    }
}

