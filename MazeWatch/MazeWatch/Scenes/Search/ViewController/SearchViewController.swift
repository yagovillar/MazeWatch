//
//  SearchShowsViewController.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 15/06/25.
//
import UIKit

final class SearchViewController: UIViewController, SearchViewModelDelegate {
    var viewModel: SearchViewModelProtocol?
    private let searchView = SearchView()
    private var debounceTimer: Timer?

    override func loadView() {
        self.view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchListener()
        searchView.showTableView.dataSource = self
        searchView.showTableView.register(MazeListCell.self, forCellReuseIdentifier: "ShowCell")
        viewModel?.delegate = self

        let imageView = UIImageView(image: UIImage(named: "iconVector"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }

    init(viewModel: SearchViewModelProtocol? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSearchListener() {
        searchView.searchBar.textField.addTarget(self,
                                                 action: #selector(searchTextChanged(_:)),
                                                 for: .editingChanged)
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

    // MARK: - SearchViewModelDelegate
    func didUpdateState(_ state: SearchState) {
        DispatchQueue.main.async {
            self.searchView.showTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getItensCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCell", for: indexPath) as? MazeListCell,
              let item = viewModel?.getItem(at: indexPath.row) else {
            return UITableViewCell()
        }
        cell.configure(imageURL: item.item.image?.medium ?? "", title: item.item.name)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelect(at: indexPath.row)
    }
}
