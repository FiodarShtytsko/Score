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
                .frame(width: Layout.imageSize, height: Layout.imageSize)
            Text(league.name)
                .foregroundStyle(.primary)
                .bold()
            Spacer()
            Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                .animation(.easeInOut(duration: Layout.animationDuration), value: isExpanded)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: Layout.animationDuration)) {
                isExpanded.toggle()
            }
        }
        .fullScreenCover(item: $selectedPages) { pages in
            TikTokPlayerWrapper(pages: pages.pages) {
                selectedPages = nil
            }
        }

        if isExpanded {
            ForEach(league.matches, id: \.id) { match in
                MatchCellView(match: match)
                    .animation(.easeInOut(duration: Layout.animationDuration), value: isExpanded)
                    .onTapGesture {
                        selectedPages = StoryPageWrapper(pages: match.pages)
                    }
            }
        }
        
    }
}

private extension LeagueCellView {
    enum Layout {
        static let imageSize: CGFloat = 24
        static let animationDuration: Double = 0.35
    }
}

struct StoryPageWrapper: Identifiable {
    let id = UUID()
    let pages: [StoryPage]
}
