import Foundation

class Game {
    var name:String;
    var year:Int;
    var userRating:Int;
    var criticRating:Int;
    var platforms:[String];
    var beatingTime:Int;
    var mode:[String];
    var genres:[String];
    var perspective:[String];
    var ageRating:Int;
    var developer:String;
    var cover:String;
    var banner:String;
    
    init(_ name: String, _ year: Int, _ uRating: Double?, _ cRating: Double, _ platform: [String]?, _ beatingTime: Int?, _ mode: [String]?, _ genres: [String], _ perspective: [String], _ aRating: Int, _ developer: String?, _ cover: String, _ banner: String){
        self.name = name;
        self.year = year;
        self.userRating = Int(uRating ?? 0);
        self.criticRating = Int(cRating);
        self.platforms = platform ?? [];
        self.beatingTime = beatingTime ?? 0;
        self.mode = mode ?? ["Single Player"];
        self.genres = genres;
        self.perspective = [];
        self.ageRating = aRating;
        self.developer = developer ?? "Não Registrado";
        self.cover = cover;
        self.banner = banner;
        
        for p in perspective {
            self.addPerspective(p);
        }
    }
    
    public func addPlatform(_ platform: String){
        platforms.append(platform)
    }
    
    public func addMode(_ mode: String){
        if ["Single Player", "MultiPlayer"].contains(mode) {
            self.mode.append(mode)
        }
    }
    
    public func addGenre(_ genre: String){
        self.genres.append(genre);
    }
    
    public func addPerspective(_ perspective:String){
        if perspective == "First Person" {
            self.perspective.append("Primeira Pessoa")
        }
        
        if perspective == "Third Person" {
            self.perspective.append("Terceira Pessoa")
        }
    }
}
