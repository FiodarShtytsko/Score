//
//  MatchResponse.swift
//  Score
//
//  Created by Fiodar Shtytsko on 24/03/2025.
//

struct MatchResponse: Codable {
    let wscGameID: String
    let league: LeagueDTO
    let fixture: Fixture
    let teams: Teams
    let wscGame: WscGame?

    enum CodingKeys: String, CodingKey {
        case wscGameID = "WSCGameId"
        case league, fixture, teams, wscGame
    }
}
