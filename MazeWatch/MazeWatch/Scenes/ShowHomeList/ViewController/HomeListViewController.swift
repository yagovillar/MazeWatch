//
//  HomeListViewController.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//
import UIKit

class HomeListViewController: UIViewController {
    var viewModel: HomeListViewModelProtocol
    private var isLoading = false
    private let homeListView = HomeListView()

    override func loadView() {
        self.view = homeListView

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        homeListView.showTalbeView.delegate = self
        homeListView.showTalbeView.dataSource = self
        homeListView.showTalbeView.register(ShowListCell.self, forCellReuseIdentifier: "ShowCell")
        viewModel.delegate = self

        let imageView = UIImageView(image: UIImage(named: "iconVector"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }

    init(viewModel: HomeListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadMoreShows() {
        guard !isLoading else { return }
        isLoading = true

        self.viewModel.fetchShows()
        self.homeListView.showTalbeView.reloadData()
        self.isLoading = false
    }

}

extension HomeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getShowCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCell", for: indexPath) as? ShowListCell
        let show = viewModel.getShow(at: indexPath.row)
        cell?.configure(imageURL: show.image?.medium ?? "", title: show.name ?? "", isFavorite: true)
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let show = viewModel.getShow(at: indexPath.row)
        viewModel.selectShow(showId: show.id ?? 0)
    }

}

extension HomeListViewController: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height

        if offsetY > contentHeight - frameHeight - 100 {
            loadMoreShows()
        }
    }
}

extension HomeListViewController: HomeListViewModelDelegate {
    func didLoadShows() {
        DispatchQueue.main.async {
            self.isLoading = false
            self.homeListView.showTalbeView.reloadData()
        }
    }
}
