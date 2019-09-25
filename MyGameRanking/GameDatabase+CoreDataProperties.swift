//
//  GameDatabase+CoreDataProperties.swift
//  MyGameRanking
//
//  Created by Aluno Mack on 24/09/19.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//
//

import Foundation
import CoreData


extension GameDatabase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameDatabase> {
        return NSFetchRequest<GameDatabase>(entityName: "GameDatabase")
    }

    @NSManaged public var ageRating: Int16
    @NSManaged public var banner: String?
    @NSManaged public var beatingTime: Int64
    @NSManaged public var cover: String?
    @NSManaged public var criticRating: Int16
    @NSManaged public var developer: String?
    @NSManaged public var genres: String?
    @NSManaged public var mode: String?
    @NSManaged public var name: String?
    @NSManaged public var perspective: String?
    @NSManaged public var platforms: String?
    @NSManaged public var screenshot: String?
    @NSManaged public var userRating: Int16
    @NSManaged public var year: Int16

}
