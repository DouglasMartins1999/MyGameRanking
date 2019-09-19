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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        searchResult.append(
            Game("Halo: Combat Evolved", 2001, 85, 87, ["PC", "Mac", "Xbox"], 39600, ["Single player", "Multiplayer", "Co-operative"], ["Shooter"], ["First person", "Third person"], 4, "Bungie", "", "")
        )
        
        GamesFetch.searchGame("Halo", callback: { (res) in
            self.searchResult = res.map { item -> Game in
                GameListAdapter(item).getAgeRating().getCompanies().getGameMode().getGenre().getPerspective().getPlatforms().getReleaseDate().getGame()
            }
            self.tableView.reloadData()
        })
    }
    
    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? MyListTableViewCell {
            let row = indexPath.row;
            cell.setGame(searchResult[row])
            return cell;
        } else {
            return UITableViewCell();
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165.5
    }
}
