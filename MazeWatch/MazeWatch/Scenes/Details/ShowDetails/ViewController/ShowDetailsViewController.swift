//
//  DetailsViewController.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//
import UIKit
class ShowDetailsViewController: UIViewController {
    var detailsView = ShowOrEpisodeDetailView()
    let viewModel: ShowDetailsViewModelProtocol
    
    init(viewModel: ShowDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalLoader.shared.show()
        configureBindings()
        setupData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.detailsView.episodeTableView.reloadData()
    }
    
    private func setupData() {
        viewModel.fetchShowDetails()
    }
    
    private func configureBindings() {
        detailsView.onSeasonButtonTap = { [weak self] in
            self?.handleSeasonButtonTap()
        }

        detailsView.episodeTableView.dataSource = self
        detailsView.episodeTableView.register(MazeListCell.self, forCellReuseIdentifier: "ShowCell")
    }
    
    private func handleSeasonButtonTap() {
        let pickerVC = SeasonPickerViewController()
        guard let seasons = viewModel.getDetails().seasons else { return }
        pickerVC.seasons = seasons
        pickerVC.onSelect = { [weak self] selectedSeason in
            DispatchQueue.main.async {
                self?.detailsView.seasonButton.setTitle("Season \(selectedSeason.number ?? 0)", for: .normal)
                self?.viewModel.selectSeason(selectedSeason.id)
            }
        }

        pickerVC.modalPresentationStyle = .pageSheet
        if let sheet = pickerVC.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(pickerVC, animated: true)
    }
    
    private func updateEpisodeList() {
        self.detailsView.episodeTableView.reloadData()
    }

}

extension ShowDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getEpisodesCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCell", for: indexPath) as? MazeListCell
        guard let episode = viewModel.getEpisode(at: indexPath.row) else { return UITableViewCell() }
        let episodeName = "\(episode.number ?? 0) - \(episode.name ?? "")"
        cell?.configure(imageURL: episode.image?.medium ?? "", title: episodeName, isFavorite: nil)
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }

}

extension ShowDetailsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.getDetails().seasons?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let season = viewModel.getDetails().seasons?[row]
        return "Temporada \(String(describing: season?.number))"
    }
}

extension ShowDetailsViewController: ShowDetailsViewModelDelegate {
    func didSelectSeason() {
        self.detailsView.episodeTableView.reloadData()
    }
    
    func didGetDetaisl() {
        self.detailsView.configureForShow(viewModel.getDetails())
        GlobalLoader.shared.hide()
    }
}
