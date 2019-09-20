//
//  IGDBList.swift
//  MyGameRanking
//
//  Created by Aluno Mack on 18/09/19.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//

import Foundation

class IGDBList:Codable {
    var age_ratings:[AgeRating]?
    var aggregated_rating:Double?

//    var cover:CoverImage?

    var cover:CoverImage?
    var game_modes:[GameModes]?
    var genres: [Genres]?
    var involved_companies:[InvolvedCompanies]?
    var name:String?
    var platforms:[Platforms]?
    var player_perspectives:[Int]?
    var rating:Double?
    var release_dates:[ReleaseDates]?

    var artworks:[Artworks]?
    var screenshots:[Artworks]?

//    var time_to_beat:TimeToBeat?
}

class AgeRating:Codable {
    var rating:Int?
}


//class CoverImage: Codable{
//    var height:Int?
//    var url:String?
//    var width:Int?
//}

class CoverImage: Codable{
    var url:String?
}

class GameModes: Codable{
    var name:String?
}

class Genres:Codable {
    var name:String?
}

class InvolvedCompanies:Codable {
    var company:Company?
    var developer:Bool?
}

class Company:Codable {
    var name:String?
}

class Platforms:Codable {
    var name:String?
}

class ReleaseDates:Codable {
    var y:Int?
}

class TimeToBeat:Codable {
    var normally:Int?
}


class Artworks:Codable {
    var url:String?
}

