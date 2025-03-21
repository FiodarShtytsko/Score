//
//  LeagueCellView.swift
//  Score
//
//  Created by Fiodar Shtytsko on 21/03/2025.
//

import SwiftUI

struct LeagueCellView: View {

    let league: League

    var body: some View {
        HStack {
            Image(uiImage: .actions)
                .frame(width: 25, height: 25)
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
