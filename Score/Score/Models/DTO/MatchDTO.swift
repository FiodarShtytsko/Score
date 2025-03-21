//
//  MatchDTO.swift
//  Score
//
//  Created by Fiodar Shtytsko on 21/03/2025.
//

import Foundation

struct MatchDTO: Decodable {
    let id: String
    let date: String
    let time: String
    let teams: [TeamDTO]
    let primeStory: PrimeStoryDTO?
    let wscGame: WSCGameDTO?
}
