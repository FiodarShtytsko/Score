//
//  MatchCellView.swift
//  Score
//
//  Created by Fiodar Shtytsko on 21/03/2025.
//

import SwiftUI
import Kingfisher

struct MatchCellView: View {
    let match: Match

    var body: some View {
        VStack {
            if match.isLive {
                isLive
            }

            HStack(alignment: .top) {
                teamLogo(for: match.teams[0])
                    .frame(maxWidth: .infinity)
                infoAboutMatch
                    .frame(maxWidth: .infinity)
                teamLogo(for: match.teams[1])
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, 8)
    }

    private var isLive: some View {
        HStack {
            Text("● LIVE")
                .font(.caption)
                .bold()
                .foregroundColor(.red)
            Spacer()
        }
    }

    private var infoAboutMatch: some View {
        VStack(spacing: Layout.infoPadding) {
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
        VStack(spacing: Layout.logoPadding) {
            KFImage(team.logoURL)
                .resizable()
                .frame(width: Layout.logoSize, height: Layout.logoSize)
            Text(team.name)
                .font(.subheadline)
                .bold()
                .multilineTextAlignment(.center)
        }
    }
}

private extension MatchCellView {
    enum Layout {
        static let logoSize: CGFloat = 30
        static let logoPadding: CGFloat = 12
        static let infoPadding: CGFloat = 4
        static let animationDuration: Double = 0.35
    }
}

