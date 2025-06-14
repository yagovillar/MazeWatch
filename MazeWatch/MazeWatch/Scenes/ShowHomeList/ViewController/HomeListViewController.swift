//
//  HomeListViewController.swift
//  MazeWatch
//
//  Created by Yago Vanzan on 13/06/25.
//
import UIKit

class HomeListViewController: UIViewController {
    var ViewModel: HomeListViewModelProtocol
    
    init(ViewModel: HomeListViewModelProtocol) {
        self.ViewModel = ViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ViewModel.fetchShows()
        title = "Home"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension HomeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewModel.getShowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let show = ViewModel.getShow(at: indexPath.row)
        
        return UITableViewCell()
    }
}
