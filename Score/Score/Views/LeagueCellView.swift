//
//  LeagueCellView.swift
//  Score
//
//  Created by Fiodar Shtytsko on 21/03/2025.
//

import SwiftUI
import Kingfisher

struct LeagueCellView: View {
    @State private var isExpanded: Bool = false
    @State private var selectedPages: StoryPageWrapper? = nil


    let league: League

    var body: some View {
        HStack {
            KFImage(league.imageURL)
                .resizable()
                .frame(width: 24, height: 24)
            Text(league.name)
                .foregroundStyle(.black)
                .bold()
            Spacer()
            Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                .animation(.easeInOut(duration: 0.35), value: isExpanded)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.35)) {
                isExpanded.toggle()
            }
        }

        if isExpanded {
            ForEach(league.matches, id: \.id) { match in
                MatchCellView(match: match)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.35), value: isExpanded)
                    .onTapGesture {
                        selectedPages = StoryPageWrapper(pages: match.pages)
                    }
                    .fullScreenCover(item: $selectedPages) { pages in
                        TikTokPlayerWrapper(pages: pages.pages)
                    }
            }
        }

    }
}

struct StoryPageWrapper: Identifiable {
    let id = UUID()
    let pages: [StoryPage]
}
