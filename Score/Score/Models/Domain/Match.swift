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
    let pages: [StoryPage]
    let isLive: Bool
}
