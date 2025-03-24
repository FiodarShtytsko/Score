//
//  Page.swift
//  Score
//
//  Created by Fiodar Shtytsko on 24/03/2025.
//

import Foundation

struct Page: Codable {
    let videoURL: URL
    let duration: Int
    let title: String?
    let homeScore: Int?
    let awayScore: Int?

    enum CodingKeys: String, CodingKey {
        case videoURL = "videoUrl"
        case duration, title, homeScore, awayScore
    }
}
