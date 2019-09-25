//
//  MyListViewController.swift
//  MyGameRanking
//
//  Created by Aluno Mack on 17/09/19.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//

import UIKit

class MyListViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    var games:[Game] = [];
    var dbGames: [GameDatabase] = []
    var currentViewGames: [Game] = []
    var gameOrder = 1
    var genres:[String] = ["Escolha uma opção: ", "Todos"]
    var chosenMode:String = ""
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var genreButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var modeButton: UIButton!
    @IBOutlet weak var orderButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chosenMode = genres[0];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        genreButton.layer.cornerRadius = genreButton.frame.height / 2;
        timeButton.layer.cornerRadius = timeButton.frame.height / 2;
        modeButton.layer.cornerRadius = modeButton.frame.height / 2;
        orderButton.layer.cornerRadius = orderButton.frame.height / 2;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        games = CoreDataManager.sharedInstance.getGames()
        dbGames = CoreDataManager.sharedInstance.getDBGames()
        currentViewGames = games
        var newGenres = currentViewGames.map{ $0.genres }.flatMap{$0}
        genres = removeDuplicates(genres: newGenres)
        tableView.reloadData()
        orderGames(gameOrder: gameOrder)
        
    }
    
    func removeDuplicates(genres: [String]) -> [String] {
        var encountered = Set<String>()
        var newArr: [String] = ["Escolha uma opção: ", "Todos"]
        for value in genres{
            if encountered.contains(value){
                
            }
            else{
                encountered.insert(value)
                newArr.append(value)
            }
        }
        return newArr
    }
    
   
    
    // Create PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenMode = genres[row]
        print(row)
        print(chosenMode)
    }
    
    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentViewGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MyListCell", for: indexPath) as? MyListTableViewCell {
            let row = indexPath.row;
            cell.setGame(currentViewGames[row])
            return cell;
        } else {
            return UITableViewCell();
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165.5
    }
    
    
    //Delete Row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let row = indexPath.row
            var gameToRemove = currentViewGames[row]
            
            for i in 0..<games.count{
                if games[i].name == gameToRemove.name{
                    CoreDataManager.sharedInstance.deleteObject(object: dbGames[i])
                    games.remove(at: i)
                    dbGames.remove(at: i)
                    currentViewGames.remove(at: row)
                    break;
                }
            }
            
            print(games.map({ $0.name }))
            tableView.reloadData()
        }
    }
    
    
    //Funções de Filtro
    
    func orderGames(gameOrder: Int){
        if gameOrder == 1{
            self.currentViewGames = self.currentViewGames.sorted(by: {$0.criticRating > $1.criticRating})
        }
        else{
            self.currentViewGames = self.currentViewGames.sorted(by: {$0.criticRating < $1.criticRating})
        }
    }
    
    func filterGameMode(gameMode: Int) -> Bool{
        if gameMode==0 {
            self.currentViewGames = self.games
            self.currentViewGames = self.currentViewGames.filter({$0.mode.contains("Single player")})
            orderGames(gameOrder: gameOrder)
            self.tableView.reloadData()
            return true
        }
        else if gameMode == 1{
            self.currentViewGames = self.games
            self.currentViewGames = self.currentViewGames.filter({$0.mode.contains("Multiplayer")})
            orderGames(gameOrder: gameOrder)
            self.tableView.reloadData()
            return true
        }
        else if gameMode == 2{
            self.currentViewGames = self.games
            self.currentViewGames = self.currentViewGames.filter({$0.mode.contains("Co-operative")})
            orderGames(gameOrder: gameOrder)
            self.tableView.reloadData()
            return true
        }
            
        else if gameMode == 22{
            orderGames(gameOrder: gameOrder)
            self.tableView.reloadData()
            return false;
        }
        else{
            self.currentViewGames = self.games
            orderGames(gameOrder: gameOrder)
            self.tableView.reloadData()
            return false;
        }
        
    }
    
    func filterGameTime(gameTime: Int) -> Bool{
        if gameTime == 0{
            self.currentViewGames = self.games
            self.currentViewGames = self.currentViewGames.filter({$0.beatingTime >= 1 && $0.beatingTime < 10})
            orderGames(gameOrder: gameOrder)
            self.tableView.reloadData()
            return true;
        }
        
        else if gameTime == 1{
            self.currentViewGames = self.games
            self.currentViewGames = self.currentViewGames.filter({$0.beatingTime >= 10 && $0.beatingTime < 25})
            orderGames(gameOrder: gameOrder)
            self.tableView.reloadData()
            return true;
        }
        
        else if gameTime == 2{
            self.currentViewGames = self.games
            self.currentViewGames = self.currentViewGames.filter({$0.beatingTime >= 25 && $0.beatingTime < 35})
            orderGames(gameOrder: gameOrder)
            self.tableView.reloadData()
            return true;
        }
        
        else if gameTime == 3{
            self.currentViewGames = self.games
            self.currentViewGames = self.currentViewGames.filter({$0.beatingTime >= 35 && $0.beatingTime < 50})
            orderGames(gameOrder: gameOrder)
            self.tableView.reloadData()
            return true;
        }
        
        else if gameTime == 4{
            self.currentViewGames = self.games
            self.currentViewGames = self.currentViewGames.filter({$0.beatingTime >= 50})
            orderGames(gameOrder: gameOrder)
            self.tableView.reloadData()
            return true;
        }
        
        else{
            self.currentViewGames = self.games
            orderGames(gameOrder: gameOrder)
            self.tableView.reloadData()
            return false;
        }
    }
    
    func filterGenres(genre: String){
        if genre == "Todos" || genre == "Escolha uma opção: "{
            self.currentViewGames = self.games
            orderGames(gameOrder: gameOrder)
            self.tableView.reloadData()
        }
        else{
            self.currentViewGames = self.games
            self.currentViewGames = self.currentViewGames.filter({$0.genres.contains(genre)})
            orderGames(gameOrder: gameOrder)
            self.tableView.reloadData()
        }
    }
    
    
    
    
    
    //Alerts
    @IBAction func showOrder(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Ordenar do: ", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Maior para o menor", style: .default, handler: { (_) in
            print("User escolheu maior-> menor")
            self.gameOrder = 1
            self.filterGameMode(gameMode: 22)
            //self.games = self.games.sorted(by: {$0.criticRating > $1.criticRating})
            //self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Menor para o maior", style: .default, handler: { (_) in
            print("User escolheu menor-> maior")
            self.gameOrder = 2
            self.filterGameMode(gameMode: 22)
            //self.currentViewGames = self.currentViewGames.sorted(by: {$0.criticRating < $1.criticRating})
            //self.tableView.reloadData()
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (_) in
            print("User escolheu cancelar")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    @IBAction func showGameModes(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Modo de Jogo: ", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Todos", style: .default, handler: { (_) in
            print("User escolheu todos")
            self.filterGameMode(gameMode: 100)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Single Player", style: .default, handler: { (_) in
            print("User escolheu singleplayer")
            self.filterGameMode(gameMode: 0)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Multiplayer", style: .default, handler: { (_) in
            print("User escolheu multiplayer")
            self.filterGameMode(gameMode: 1)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cooperativo", style: .default, handler: { (_) in
            print("User escolheu cooperativo")
            self.filterGameMode(gameMode: 2)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (_) in
            print("User escolheu cancelar")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    @IBAction func showGameTime(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Escolha a Duração: ", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Todos", style: .default, handler: { (_) in
            print("User escolheu Todos")
            self.filterGameTime(gameTime: 100)
        }))
        
        alert.addAction(UIAlertAction(title: "Até 10 horas", style: .default, handler: { (_) in
            print("User escolheu singleplayer")
            self.filterGameTime(gameTime: 0)
        }))
        
        alert.addAction(UIAlertAction(title: "De 10 a 25 horas", style: .default, handler: { (_) in
            print("User escolheu multiplayer")
            self.filterGameTime(gameTime: 1)
        }))
        
        alert.addAction(UIAlertAction(title: "De 25 a 35 horas", style: .default, handler: { (_) in
            print("User escolheu cooperativo")
            self.filterGameTime(gameTime: 2)
        }))
        
        alert.addAction(UIAlertAction(title: "De 35 a 50 horas", style: .default, handler: { (_) in
            print("User escolheu cooperativo")
            self.filterGameTime(gameTime: 3)
        }))
        
        alert.addAction(UIAlertAction(title: "Mais que 50 horas", style: .default, handler: { (_) in
            print("User escolheu cooperativo")
            self.filterGameTime(gameTime: 4)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (_) in
            print("User escolheu cancelar")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    @IBAction func showGenders(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 200)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 200))
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(pickerView)
        let editRadiusAlert = UIAlertController(title: "Gênero: ", message: "", preferredStyle: UIAlertController.Style.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Concluido", style: .default, handler: {(UIAlertAction) -> Void in
            //print("Oi")
            self.filterGenres(genre: self.chosenMode)
        }))
        editRadiusAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
                //print(chosenMode)
        self.present(editRadiusAlert, animated: true)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? SearchViewController {
            dest.listController = self
        }
        
        if let dest = segue.destination as? GameDetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                let row = indexPath.row;
                dest.game = currentViewGames[row];
            }
        }
    }

}
