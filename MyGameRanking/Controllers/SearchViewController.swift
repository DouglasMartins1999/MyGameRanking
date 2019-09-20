//
//  SearchViewController.swift
//  MyGameRanking
//
//  Created by Aluno Mack on 18/09/19.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var searchResult:[Game] = []

    weak var listController:MyListViewController?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? MyListTableViewCell {
            let row = indexPath.row;
            cell.setGame(searchResult[row])
            cell.addButton.tag = indexPath.row
            return cell;
        } else {
            return UITableViewCell();
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165.5
    }
    
    // SearchBar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, searchText.count > 0 {
            GamesFetch.searchGame(searchText, callback: { (res) in
                self.searchResult = res.map { item -> Game in
                    GameListAdapter(item)
                        .getAgeRating()
                        .getCompanies()
                        .getGameMode()
                        .getGenre()
                        .getPerspective()
                        .getPlatforms()
                        .getReleaseDate()
                        .getCover()
                        .getScreenshot()
                        .getArtwork()
                        .getTime()
                        .getGame()
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    @IBAction func addGameToMyList(_ sender: UIButton) {
        listController?.games.append(searchResult[sender.tag])
        navigationController?.popViewController(animated: true)
    }
}
