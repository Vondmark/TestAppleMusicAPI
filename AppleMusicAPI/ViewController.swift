//
//  ViewController.swift
//  AppleMusicAPI
//
//  Created by Mark on 12.03.2020.
//  Copyright © 2020 Mark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let networkService = NetworkService()
    var searchResponse:SearchResponse? = nil
    private var timer: Timer?
    
    @IBOutlet weak var musicTable: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
        
        
        
    }
    
    
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }

    private func setupTableView() {
        musicTable.delegate = self
        musicTable.dataSource = self
        musicTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let track = searchResponse?.results[indexPath.row]
        cell.textLabel?.text = track?.trackName
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let urlString = "https://itunes.apple.com/search?term=\(searchText)&limit=25"
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkService.request(urlString: urlString) { [weak self] (result) in
                switch result {
                    
                case .success(let searchResponse ):
                    self?.searchResponse = searchResponse
                    self?.musicTable.reloadData()
                case .failure(let error):
                    print("error", error)
                }
            }
        })
        
    }
}
