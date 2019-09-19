//
//  MyListTableViewCell.swift
//  MyGameRanking
//
//  Created by Aluno Mack on 17/09/19.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//

import UIKit

class MyListTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var platforms: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setGame(_ game:Game){
        self.name.text = game.name;
        self.year.text = String(game.year) ?? "Não Registrado";
        self.platforms.text = setPlatforms(game.platforms);
        self.genres.text = setGenres(game.genres);
        self.rating?.text = String(game.criticRating) ?? "0";
    }
    
    private func setPlatforms(_ plat:[String]) -> String {
        return plat.joined(separator: ", ")
    }
    
    private func setGenres(_ genres:[String]) -> String {
        return genres.joined(separator: ", ")
    }
}
