//
//  Match.swift
//  Score
//
//  Created by Fiodar Shtytsko on 21/03/2025.
//

import Foundation

struct Match {
    let id: String
    let teams: [Team]
    let date: String
    let time: String
    let score: String
    let isLive: Bool
}

#if DEBUG
let mockMatches: [Match] = [
    Match(
        id: UUID().uuidString,
        teams: [
            Team(
                id: UUID().uuidString,
                name: "Barcelona",
                logoURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/4/47/FC_Barcelona_%28crest%29.svg")!
            ),
            Team(
                id: UUID().uuidString,
                name: "Real Madrid",
                logoURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/5/56/Real_Madrid_CF.svg")!
            )
        ],
        date: "21 Mar 2025",
        time: "20:45",
        score: "2 - 1",
        isLive: false
    ),
    Match(
        id: UUID().uuidString,
        teams: [
            Team(id: UUID().uuidString, name: "Arsenal", logoURL: URL(string: "https://media-3.api-sports.io/football/teams/563.png")!),
            Team(id: UUID().uuidString, name: "Manchester City", logoURL: URL(string: "https://media-3.api-sports.io/football/teams/4505.png")!)
        ],
        date: "21 Mar 2025",
        time: "18:30",
        score: "1 - 3",
        isLive: true
    )
]
#endif
