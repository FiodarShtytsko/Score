//
//  LeagueMapper.swift
//  Score
//
//  Created by Fiodar Shtytsko on 24/03/2025.
//
import Foundation

enum LeagueMapper {
    static func map(rawMatches: [MatchResponse]) -> [League] {
        let grouped = Dictionary(grouping: rawMatches, by: { $0.league.id })

        return grouped.compactMap { _, matches -> League? in
            guard let first = matches.first else { return nil }

            let validMatches = matches
                .filter { $0.wscGame?.primeStory != nil }
                .compactMap(map)

            guard !validMatches.isEmpty else { return nil }

            return League(
                id: String(first.league.id),
                name: first.league.name,
                imageURL: URL(string: first.league.logo),
                matches: validMatches
            )
        }
    }

    private static func map(_ dto: MatchResponse) -> Match? {
        guard let home = dto.teams.home, let away = dto.teams.away else {
            return nil
        }

        let isLive = dto.fixture.status.short != "NS"

        let lastPage = dto.wscGame?.primeStory?.pages.last
        let score = [lastPage?.homeScore, lastPage?.awayScore]
            .compactMap { $0 }
            .map(String.init)
            .joined(separator: " - ")

        let pages = dto.wscGame?.primeStory?.pages.map {
            StoryPage(
                id: UUID().uuidString,
                videoURL: $0.videoURL,
                duration: $0.duration,
                title: $0.title
            )
        } ?? []

        let parsedDate = inputDateFormatter.date(from: dto.fixture.date)
        let dateString = parsedDate.map { displayDateFormatter.string(from: $0) } ?? "-"
        let timeString = parsedDate.map { displayTimeFormatter.string(from: $0) } ?? "-"

        return Match(
            id: dto.wscGameID,
            teams: [
                Team(id: String(home.id), name: home.name, logoURL: home.logo),
                Team(id: String(away.id), name: away.name, logoURL: away.logo)
            ],
            date: dateString,
            time: timeString,
            score: score.isEmpty ? "-" : score,
            pages: pages,
            isLive: isLive
        )
    }
}

private extension LeagueMapper {
    private static let inputDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    private static let displayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()

    private static let displayTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}
