import UIKit

class GamesFetch {
    static func searchGame(_ query: String, callback: @escaping ([IGDBList]) -> ()){
        if let url:URL = URL(string: "https://api-v3.igdb.com/games/") {
            var urlRequest:URLRequest = URLRequest(url: url);
            urlRequest.httpMethod = "GET"
            urlRequest.httpBody = "search \"\(query)\"; fields name, release_dates.y, platforms.name, genres.name, cover.height, cover.width, cover.url, involved_companies.company.name,  involved_companies.developer , aggregated_rating, rating, game_modes.name, player_perspectives, time_to_beat.normally, age_ratings.rating, artworks.url, screenshots.url;".data(using: .utf8)
            urlRequest.setValue("06e6fa9873ef43137e415a554480d8e1", forHTTPHeaderField: "user-key")
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if error == nil {
                    if let data = data {
                        if let res:[IGDBList] = try? JSONDecoder().decode(Array<IGDBList>.self, from: data){
                            callback(res)
                        }
                    }
                } else {
                    print(error)
                }
            }.resume()
        }
    }

    
    static func fetchImages(_ url: URL, callback: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: callback).resume()
    }
}
