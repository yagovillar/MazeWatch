//
//  SearchShowsViewController.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//
import UIKit

class SearchShowsViewController: UIViewController {
    var viewModel: SearchShowsViewModelProtocol?
    private let searchShowsView = SearchShowsView()
    private var debounceTimer: Timer?

    override func loadView() {
        self.view = searchShowsView
        setupSearchListener()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchShowsView.showTalbeView.dataSource = self
        searchShowsView.showTalbeView.register(ShowListCell.self, forCellReuseIdentifier: "ShowCell")
        viewModel?.delegate = self
        // Set an image as the navigation bar title
        let imageView = UIImageView(image: UIImage(named: "iconVector"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }

    init(viewModel: SearchShowsViewModelProtocol? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchListener() {
        searchShowsView.searchBar.textField.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
    }

    @objc private func searchTextChanged(_ sender: UITextField) {
        debounceTimer?.invalidate()

        guard let query = sender.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            viewModel?.clearResults()
            return
        }

        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.viewModel?.search(query: query)
        }
    }

}

extension SearchShowsViewController: SearchShowsViewModelDelegate {
    func didSearch() {
        self.searchShowsView.showTalbeView.reloadData()
    }
}

extension SearchShowsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getShowsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCell", for: indexPath) as? ShowListCell
        let show = viewModel?.getShow(at: indexPath.row)
        cell?.configure(imageURL: show?.image?.medium ?? "", title: show?.name ?? "", isFavorite: false)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.didSelectShow(at: indexPath.row)
    }
}
