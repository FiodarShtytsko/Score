//
//  LeagueCellView.swift
//  Score
//
//  Created by Fiodar Shtytsko on 21/03/2025.
//

import SwiftUI
import Kingfisher

struct LeagueCellView: View {

    let league: League

    var body: some View {
        HStack {
            KFImage(league.imageURL)
                .resizable()
                .frame(width: 24, height: 24)
            Text(league.name)
                .bold()
            Spacer()
            Image(systemName: "chevron.right")
        }

        ForEach(league.matches, id: \.id) { match in
            MatchCellView(match: match)
        }
    }
}
