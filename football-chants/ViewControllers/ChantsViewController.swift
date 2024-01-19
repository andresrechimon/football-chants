//
//  ChantsViewController.swift
//  football-chants
//
//  Created by Andrés Rechimon on 19/01/2024.
//

import UIKit

class ChantsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 44
        table.separatorStyle = .none
        table.register(TeamTableViewCell.self, forCellReuseIdentifier: TeamTableViewCell.cellID)
        
        return table
    }()
    
    private lazy var teamsViewModel = TeamsViewModel()
    private lazy var audioManagerModel = AudioManagerViewModel()
    
    override func loadView() {
        super.loadView()
        
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }
}

private extension ChantsViewController {
    func setup(){
        self.navigationController?.navigationBar.topItem?.title = "Football Chants"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension ChantsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsViewModel.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let team = teamsViewModel.teams[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.cellID, for: indexPath) as! TeamTableViewCell
        cell.configure(with: team, delegate: self)
        
        return cell
    }
}

extension ChantsViewController: TeamTableViewCellDelegate {
    func didTapPlayback(for team: Team) {
        audioManagerModel.playback(team)
        teamsViewModel.togglePlayback(for: team)
        tableView.reloadData()
    }
}
