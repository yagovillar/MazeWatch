import XCTest
@testable import MazeWatch

extension Show {
    static func fixture(
        id: Int = 1,
        name: String = "Sample Show",
        image: ShowImage? = ShowImage(medium: "https://example.com/medium.jpg", original: "https://example.com/original.jpg"),
        summary: String? = "This is a sample show summary."
    ) -> Show {
        return Show(id: id, name: name, image: image, summary: summary)
    }
}

extension ShowDetails {
    static func fixture(
        id: Int = 1,
        url: String = "https://example.com/show",
        name: String = "Sample Show Detail",
        type: String = "Scripted",
        language: String? = "English",
        genres: [String] = ["Drama", "Thriller"],
        status: String? = "Running",
        runtime: Int? = 60,
        averageRuntime: Int? = 60,
        premiered: String? = "2023-01-01",
        officialSite: String? = "https://example.com",
        schedule: Schedule = Schedule(time: "21:00", days: ["Monday", "Thursday"]),
        rating: Rating? = Rating(average: 8.5),
        weight: Int? = 100,
        network: Network? = Network(id: 1, name: "Network Name", country: Country(name: "USA", code: "US", timezone: "America/New_York")),
        image: ShowImage? = ShowImage(medium: "https://example.com/medium.jpg", original: "https://example.com/original.jpg"),
        summary: String? = "Detailed show summary",
        seasons: [Season]? = nil
    ) -> ShowDetails {
        return ShowDetails(
            id: id,
            url: url,
            name: name,
            type: type,
            language: language,
            genres: genres,
            status: status,
            runtime: runtime,
            averageRuntime: averageRuntime,
            premiered: premiered,
            officialSite: officialSite,
            schedule: schedule,
            rating: rating,
            weight: weight,
            network: network,
            image: image,
            summary: summary,
            seasons: seasons ?? []
        )
    }
}

extension Season {
    static func fixture(
        id: Int = 1,
        url: String = "https://example.com/season/1",
        number: Int? = 1,
        name: String? = nil,
        episodeOrder: Int? = 10,
        premiereDate: String? = "2023-01-01",
        endDate: String? = "2023-03-01",
        network: Network? = nil,
        webChannel: Channel? = nil,
        image: ShowImage? = nil,
        summary: String? = "Season summary",
        links: Link? = nil,
        episodes: [Episode] = []
    ) -> Season {
        return Season(
            id: id,
            url: url,
            number: number,
            name: name,
            episodeOrder: episodeOrder,
            premiereDate: premiereDate,
            endDate: endDate,
            network: network,
            webChannel: webChannel,
            image: image,
            summary: summary,
            links: links,
            episodes: episodes
        )
    }
}

extension Episode {
    static func fixture(
        id: Int = 1,
        url: String = "https://example.com/episode/1",
        name: String = "Episode 1",
        season: Int = 1,
        number: Int = 1,
        type: String? = nil,
        airdate: String? = nil,
        airtime: String? = nil,
        airstamp: String? = nil,
        runtime: Int? = nil,
        rating: Rating? = nil,
        image: ShowImage? = nil,
        summary: String? = "Episode summary"
    ) -> Episode {
        return Episode(
            id: id,
            url: url,
            name: name,
            season: season,
            number: number,
            type: type,
            airdate: airdate,
            airtime: airtime,
            airstamp: airstamp,
            runtime: runtime,
            rating: rating,
            image: image,
            summary: summary
        )
    }
}
