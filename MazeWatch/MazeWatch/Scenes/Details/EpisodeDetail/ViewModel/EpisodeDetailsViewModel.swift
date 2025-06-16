//
//  EpisodeDetailsViewModel.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 16/06/25.
//
protocol EpisodeDetailsViewModelProtocol {
    func getEpisode() -> Episode
    func getShow() -> ShowDetails
}

class EpisodeDetailsViewModel: EpisodeDetailsViewModelProtocol {
    var episode: Episode
    var show: ShowDetails
    
    init(episode: Episode, show: ShowDetails) {
        self.episode = episode
        self.show = show
    }
    
    func getEpisode() -> Episode {
        return episode
    }
    
    func getShow() -> ShowDetails {
        return show
    }
}
