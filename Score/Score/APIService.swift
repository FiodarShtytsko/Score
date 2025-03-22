//
//  APIService.swift
//  Score
//
//  Created by Fiodar Shtytsko on 21/03/2025.
//

import Foundation

enum APIService {
    static func fetchLeagues(from url: URL) async throws -> [League] {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(MainResponse.self, from: data)
        return LeagueMapper.map(rawMatches: decoded.response)
    }
}


enum LeagueMapper {
    static func map(rawMatches: [Response]) -> [League] {
        let grouped = Dictionary(grouping: rawMatches) { $0.league.id }

        return grouped.compactMap { _, matches in
            guard let first = matches.first else { return nil }

            let validMatches = matches
                .filter { $0.wscGame?.primeStory != nil }
                .map(map)

            guard !validMatches.isEmpty else { return nil }

            return League(
                id: String(first.league.id),
                name: first.league.name.rawValue,
                imageURL: URL(string: first.league.logo) ?? URL(string: "https://placeholder.com")!,
                matches: validMatches
            )
        }
    }

    private static func map(_ dto: Response) -> Match {
        let isLive = dto.fixture.status.short != .ns

        let home = dto.teams.home
        let away = dto.teams.away

        let score = dto.wscGame?.primeStory?.pages.last?.homeScore
        let awayScore = dto.wscGame?.primeStory?.pages.last?.awayScore
        let finalScore = [score, awayScore].compactMap { $0 }.map { String($0) }.joined(separator: " - ")

        let pages = dto.wscGame?.primeStory?.pages.map { page in
            StoryPage(
                id: UUID().uuidString,
                videoURL: page.videoURL,
                duration: page.duration,
                title: page.title
            )
        } ?? []

        return Match(
            id: dto.wscGameID,
            teams: [
                Team(id: String(home!.id), name: home!.name, logoURL: home!.logo),
                Team(id: String(away!.id), name: away!.name, logoURL: away!.logo)
            ],
            date: dto.fixture.date,
            time: dto.fixture.date,
            score: finalScore.isEmpty ? "-" : finalScore,
            pages: pages,
            isLive: isLive
        )
    }
}
