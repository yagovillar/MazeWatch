//
//  DetailsModel.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//
protocol DetailsManagerProtocol {
    func getDetails() -> ShowDetails
    func setDetails(_ details: ShowDetails)
    func getEpisodesList() -> [Episode]?
    func setEpisodesList(season: Int)
    var count: Int? { get }
    var id: Int? { get set }
}

class DetailsManager: DetailsManagerProtocol {
    
    var id: Int?
    var count: Int?
    
    private var showDetails: ShowDetails?
    private var episodesList: [Episode]?
    
    func getDetails() -> ShowDetails {
        if let showDetails = self.showDetails {
            return showDetails
        }
        return ShowDetails.getEmptyShowDetails()
    }
    
    func setDetails(_ details: ShowDetails) {
        self.showDetails = details
    }
    
    func setEpisodesList(season: Int) {
        self.episodesList = showDetails?.seasons?.first(where: {$0.id == season})?.episodes
    }
    
    func getEpisodesList() -> [Episode]? {
        return self.episodesList
    }
}
