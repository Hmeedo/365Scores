//
//  GamesTimeLineView.swift
//  Assignment365Scores
//
//  Created by Hameed Dahabry on 20/06/2024.
//

import UIKit

protocol GamesTimeLineViewProtocol: AnyObject {
    func showTimeLine()
    func showError(error: String)
    func showLoading()
}

class GamesTimeLineViewController: UITableViewController, GamesTimeLineViewProtocol {
    var presenter: GamesTimeLinePresenter!
    
    override func viewDidLoad() {
        setupViews()
        presenter.viewLoaded()
    }
    
    func showTimeLine() {
        self.tableView.backgroundView = nil
        tableView.reloadData()
    }
    
    func showError(error: String) {
        self.tableView.backgroundView = nil
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { [weak self] _ in
            self?.presenter.reloadButtonPressed()
        }))
        self.present(alertController, animated: true)
    }
    
    func showLoading() {
        let activity = UIActivityIndicatorView(style: .large)
        activity.startAnimating()
        self.tableView.backgroundView = activity
    }
    
    private func setupViews() {
        title = "365 Scores"
        tableView.register(UINib(nibName: "DateCell", bundle: .main), forCellReuseIdentifier: TimeLineObjectType.date.rawValue)
        tableView.register(UINib(nibName: "GameCell", bundle: .main), forCellReuseIdentifier: TimeLineObjectType.game.rawValue)
        tableView.register(UINib(nibName: "CompetitionCell", bundle: .main), forCellReuseIdentifier: TimeLineObjectType.competition.rawValue)
    }
}

extension GamesTimeLineViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfTimeLineObjects()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(
            withIdentifier: presenter.timeLineObjectAtRow(indexPath.row).type.rawValue,
            for: indexPath
        )
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let timeLineCell = cell as? TimeLineObjectView
        timeLineCell?.configure(with: presenter.timeLineObjectAtRow(indexPath.row))
    }
}
