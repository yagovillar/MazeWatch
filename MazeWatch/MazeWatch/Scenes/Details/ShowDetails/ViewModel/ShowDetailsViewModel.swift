//
//  DetailsViewModel.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//

protocol ShowDetailsViewModelDelegate: AnyObject {
    func didGetDetaisl()
    func didSelectSeason()
}

protocol ShowDetailsViewModelProtocol: AnyObject {
    func getEpisodesCount() -> Int
    func getEpisode(at index: Int) -> Episode?
    func selectSeason(_ season: Int)
    func fetchShowDetails()
    func getDetails() -> ShowDetails
    func selectEpisode(episode at: Int)
}

class ShowDetailsViewModel: ShowDetailsViewModelProtocol {
    var service: MazeServiceProtocol
    let model: DetailsManagerProtocol
    weak var delegate: ShowDetailsViewModelDelegate?
    weak var coordinatorDelegate: HomeListCoordinatorDelegate?

    init(service: MazeServiceProtocol, model: DetailsManagerProtocol, delegate: ShowDetailsViewModelDelegate? = nil) {
        self.service = service
        self.model = model
    }
    
    func fetchShowDetails() {
        Task {
            do {
                guard let showId = model.id else { return }
                var seasons = try await service.fetchSeasons(for: showId)
                for index in seasons.indices {
                    seasons[index].episodes = try await service.fetchEpisodes(for: seasons[index].id)
                }
                var show = try await service.fetchShowDetail(id: showId)
                
                show.seasons = seasons
                
                model.setDetails(show)
                model.setEpisodesList(season: show.seasons?.first?.id ?? 0)
                self.delegate?.didGetDetaisl()
            } catch {
                GlobalErrorHandler.shared.showError(error.localizedDescription)
                self.delegate?.didGetDetaisl()
            }
        }
    }
    
    func selectSeason(_ season: Int) {
        model.setEpisodesList(season: season)
        self.delegate?.didSelectSeason()
    }
    
    func getDetails() -> ShowDetails {
        return model.getDetails()
    }
    
    func getEpisodesCount() -> Int {
        return model.getEpisodesList()?.count ?? 0
    }
    
    func getEpisode(at index: Int) -> Episode? {
        let episodesList = model.getEpisodesList()
        return episodesList?[index]
    }
    
    func selectEpisode(episode at: Int) {
        guard let episode = model.getEpisodesList()?[at] else { return }
        coordinatorDelegate?.didSelectEpisode(episode: episode, show: model.getDetails())
    }

}
