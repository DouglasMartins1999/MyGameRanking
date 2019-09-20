//
//  GameDetailViewController.swift
//  MyGameRanking
//
//  Created by Aluno Mack on 19/09/19.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//

import UIKit

class GameDetailViewController: UIViewController {
    var game:Game = Game("", 0, 100, 100, [], nil, [], [], [], 0, "", "", "", "")
    
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var developer: UILabel!
    @IBOutlet weak var platform: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var mode: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var perspective: UILabel!
    @IBOutlet weak var cRating: UILabel!
    @IBOutlet weak var uRating: UILabel!
    @IBOutlet weak var screenshot: UIImageView!
    @IBOutlet weak var aRating: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        setGame(self.game)
        genre.sizeToFit();
        mode.sizeToFit();
        perspective.sizeToFit();
    }
    
    public func setGame(_ game: Game){
        self.gameName.text = game.name
        self.year.text = String(game.year) ?? "Não Registrado";
        self.platform.text = setPlatforms(game.platforms);
        self.genre.text = setGenres(game.genres);
        self.developer.text = game.developer;
        self.mode.text = setMode(game.mode);
        self.perspective.text = setPerspective(game.perspective);
        self.cRating.text = String(game.criticRating) ?? "N/A";
        self.uRating.text = String(game.userRating) ?? "N/A";
        
        setArtwork(game.banner, game.screenshot)
        setAgeRating(game.ageRating)
    }
    
    private func setScreenshot(_ s: String) {
        guard let url = URL(string: s) else { return }
        GamesFetch.fetchImages(url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.screenshot.image = UIImage(data: data)
            }
        }
    }
    
    private func setArtwork(_ b: String, _ s: String) {
        guard let url = URL(string: b) else { return }
        GamesFetch.fetchImages(url) { data, response, error in
            if let data = data, error == nil {
                DispatchQueue.main.async() {
                    self.screenshot.image = UIImage(data: data)
                }
            } else {
                self.setScreenshot(s)
            }
        }
    }
    
    private func setPlatforms(_ plat:[String]) -> String {
        return plat.joined(separator: ", ")
    }
    
    private func setGenres(_ genres:[String]) -> String {
        return genres.joined(separator: "\n")
    }
    
    private func setMode(_ modes:[String]) -> String {
        return modes.joined(separator: "\n")
    }
    
    private func setPerspective(_ perspectives:[String]) -> String {
        return perspectives.joined(separator: "\n")
    }
    
    private func setAgeRating(_ age:Int) {
        self.aRating.image = UIImage(named: String(age))
    }
}
