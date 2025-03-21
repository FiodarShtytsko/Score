//
//  MatchCellView.swift
//  Score
//
//  Created by Fiodar Shtytsko on 21/03/2025.
//

import SwiftUI

struct MatchCellView: View {
    let match: Match

    var body: some View {
        VStack {
            isLive
            HStack {
                teamLogo(for: match.teams[0])
                    .frame(maxWidth: .infinity)
                infoAboutMatch
                    .frame(maxWidth: .infinity)
                teamLogo(for: match.teams[1])
                    .frame(maxWidth: .infinity)
            }
        }
    }

    private var isLive: some View {
        HStack {
            Image(systemName: "dot.circle.fill")
                .frame(width: 12, height: 12)
                .foregroundColor(.red)
            Text("Live")
                .font(.caption)
                .foregroundColor(.red)
            Spacer()
        }
    }

    private var infoAboutMatch: some View {
        VStack(spacing: 4) {
            Text(match.date)
                .font(.caption)
                .foregroundStyle(.gray)
            Text(match.time + " - Started")
                .font(.caption)
                .foregroundStyle(.gray)
            Spacer()
            Text(match.score)
                .font(.subheadline)
                .foregroundStyle(.red)
            Spacer()
        }
        .multilineTextAlignment(.center)
    }

    private func teamLogo(for team: Team) -> some View {
        VStack(spacing: 4) {
            Image(uiImage: .add)
                .resizable()
                .frame(width: 30, height: 30)

            Text(team.name)
                .font(.subheadline)
                .bold()
                .multilineTextAlignment(.center)
        }
    }
}


