//
//  LeagueDTO.swift
//  Score
//
//  Created by Fiodar Shtytsko on 21/03/2025.
//

import Foundation

struct LeagueDTO: Decodable {
    let id: String
    let name: String
    let imageUrl: URL
    let matches: [MatchDTO]
}

struct PrimeStoryDTO: Decodable {
}
