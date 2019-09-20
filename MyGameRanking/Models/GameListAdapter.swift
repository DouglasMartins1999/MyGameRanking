//
//  GameListAdapter.swift
//  MyGameRanking
//
//  Created by Aluno Mack on 18/09/19.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//

import Foundation

class GameListAdapter {
    var APIresponse:IGDBList
    var ageRating:Int;
    var gameMode:[String];
    var genres:[String];
    var developer:String;
    var platforms:[String];
    var perspectives:[String];
    var year:Int;
    var cover:String;
    var time:Int;
    var screenshot:String;
    var artwork:String;
    
    init(_ apiResponse:IGDBList){
        self.APIresponse = apiResponse
        
        self.ageRating = 0;
        self.gameMode = [];
        self.genres = [];
        self.developer = "";
        self.platforms = [];
        self.perspectives = [];
        self.year = 0;
        self.cover = "";
        self.screenshot = "";
        self.time = -1;
        self.artwork = "";
    }
    
    func getAgeRating() -> GameListAdapter {
        let europeanRating = APIresponse.age_ratings?.filter( { $0.rating ?? 0 <= 5 })
        for r in europeanRating ?? [] {
            ageRating = r.rating ?? 0
        }
        return self
    }
    
    func getGameMode() -> GameListAdapter {
        gameMode = APIresponse.game_modes?.map({ $0.name ?? "Não Especificado" }) ?? ["Não Especificado"]
        return self
    }
    
    func getGenre() -> GameListAdapter {
        genres = APIresponse.genres?.map({ $0.name ?? "Não Especificado" }) ?? ["Não Especificado"]
        return self
    }
    
    func getCompanies() -> GameListAdapter {
        let developers = APIresponse.involved_companies?.filter({ $0.developer == true }) ?? []
        if developers.count > 0 {
            self.developer = developers[0].company?.name ?? "Não Especificado"
        }
        return self
    }
    
    func getPlatforms() -> GameListAdapter {
        platforms = APIresponse.platforms?.map({ $0.name ?? "" }) ?? []
        return self
    }
    
    func getPerspective() -> GameListAdapter {
        perspectives = APIresponse.player_perspectives?.map({ $0 == 1 ? "Primeira Pessoa" : "Terceira Pessoa" }) ?? []
        return self
    }
    
    func getReleaseDate() -> GameListAdapter {
        year = APIresponse.release_dates?.map({ $0.y })[0] ?? 0
        return self
    }
        
    func getCover() -> GameListAdapter {
        cover = APIresponse.cover?.url?.replacingOccurrences(of: "thumb", with: "cover_big") ?? ""
        cover = cover.replacingOccurrences(of: "//", with: "https://")
        return self;
    }
    
    func getScreenshot() -> GameListAdapter {
        screenshot = APIresponse.screenshots?[0].url?.replacingOccurrences(of: "thumb", with: "screenshot_big") ?? ""
        screenshot = screenshot.replacingOccurrences(of: "//", with: "https://")
        return self;
    }
    
    func getArtwork() -> GameListAdapter {
        artwork = APIresponse.artworks?[0].url?.replacingOccurrences(of: "thumb", with: "screenshot_big") ?? ""
        artwork = artwork.replacingOccurrences(of: "//", with: "https://")
        return self;
    }
    
    func getTime() -> GameListAdapter {
        return self
    }
    
    func getGame() -> Game {
        return Game(APIresponse.name ?? "", year, APIresponse.rating, APIresponse.aggregated_rating ?? 0, platforms, nil, gameMode, genres, perspectives, ageRating, developer, cover, screenshot, artwork)

    }
}
