//
//  CoreDataManager.swift
//  MyGameRanking
//
//  Created by Aluno Mack on 23/09/19.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//
//
//  CoreDataManager.swift
//  CoreDataIntro
//
//  Created by Bruno Omella Mainieri on 22/09/19.
//  Copyright © 2019 Bruno Omella Mainieri. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager{
    
    static let sharedInstance = CoreDataManager()
    
    private init (){}
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "MyGameRanking")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func getGames() -> [Game] {
        do{
            let games:[GameDatabase] = try persistentContainer.viewContext.fetch(GameDatabase.fetchRequest())
            return games.map({
                Game($0.name ?? "Sem Dados", Int($0.year), Double($0.userRating), Double($0.criticRating), $0.platforms?.components(separatedBy: ", "), Int($0.beatingTime), $0.mode?.components(separatedBy: ", "), $0.genres?.components(separatedBy: ", ") ?? [], $0.perspective?.components(separatedBy: ", ") ?? [], Int($0.ageRating), $0.developer, $0.cover ?? "", $0.screenshot ?? "", $0.screenshot ?? "")
            })
        } catch {
            print("CoreData error")
        }
        return []
    }
    
    func getDBGames() -> [GameDatabase]{
        do{
            return try persistentContainer.viewContext.fetch(GameDatabase.fetchRequest())
            
        } catch {
            print("CoreData error")
        }
        return []
    }
    
    
    
    func insertGame( _ name: String, _ year: Int, _ uRating: Double?, _ cRating: Double, _ platform: [String]?, _ beatingTime: Int?, _ mode: [String]?, _ genres: [String], _ perspective: [String], _ aRating: Int, _ developer: String?, _ cover: String, _ screenshot: String, _ banner: String) {
        
        guard let newGame = NSEntityDescription.insertNewObject(forEntityName: "GameDatabase", into: persistentContainer.viewContext) as? GameDatabase else { return }
        newGame.name = name
        newGame.year = Int16(year);
        newGame.userRating = Int16(uRating ?? 0);
        newGame.criticRating = Int16(cRating);
        newGame.platforms = platform?.joined(separator: ", ")
        newGame.beatingTime = Int64(beatingTime ?? 0);
        newGame.mode = mode?.joined(separator: ", ")
        newGame.genres = genres.joined(separator: ", ")
        newGame.perspective = perspective.joined(separator: ", ")
        newGame.ageRating = Int16(aRating);
        newGame.developer = developer ?? "Não Especificado";
        newGame.cover = cover;
        newGame.banner = banner;
        newGame.screenshot = screenshot;
        saveContext()
    }
    
    func insertGame(game: Game) {
        self.insertGame(game.name, game.year, Double(game.userRating), Double(game.criticRating), game.platforms, game.beatingTime, game.mode, game.genres, game.perspective, game.ageRating, game.developer, game.cover, game.screenshot, game.banner)
    }
    
    
    func deleteObject(object:NSManagedObject) {
        persistentContainer.viewContext.delete(object)
        saveContext()
    }

}
