//
//  EpisodeDetailsViewController.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 16/06/25.
//
import UIKit

class EpisodeDetailsViewController: UIViewController {
    var viewModel: EpisodeDetailsViewModelProtocol
    var detailsView = ShowOrEpisodeDetailView()
    
    init(viewModel: EpisodeDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalLoader.shared.show()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GlobalLoader.shared.hide()
    }
    
    func setupView() {
        let episode = viewModel.getEpisode()
        let show = viewModel.getShow()
        detailsView.configureForEpisode(episode, show: show)
    }
}
