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

    let genres:[String] = ["Todos","Ação","Aventura", "Shooter"]
    var chosenMode:String = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chosenMode = genres[0];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        var g = Game("Halo: Combat Evolved", 2001, 85, 87, ["PC", "Mac", "Xbox"], 39600, ["Single player", "Multiplayer", "Co-operative"], ["Shooter"], ["First person", "Third person"], 4, "Bungie", "", "")
        games.append(g)
    }
    
    //Create PickerView
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
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MyListCell", for: indexPath) as? MyListTableViewCell {
            let row = indexPath.row;
            cell.setGame(games[row])
            return cell;
        } else {
            return UITableViewCell();
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165.5
    }
    
    //Alerts
    @IBAction func showOrder(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Ordenar do: ", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Maior para o menor", style: .default, handler: { (_) in
            print("User escolheu maior-> menor")
        }))
        
        alert.addAction(UIAlertAction(title: "Menor para o maior", style: .default, handler: { (_) in
            print("User escolheu menor-> maior")
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
        alert.addAction(UIAlertAction(title: "Single Player", style: .default, handler: { (_) in
            print("User escolheu singleplayer")
        }))
        
        alert.addAction(UIAlertAction(title: "Multiplayer", style: .default, handler: { (_) in
            print("User escolheu multiplayer")
        }))
        
        alert.addAction(UIAlertAction(title: "Cooperativo", style: .default, handler: { (_) in
            print("User escolheu cooperativo")
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
        alert.addAction(UIAlertAction(title: "Até 10 horas", style: .default, handler: { (_) in
            print("User escolheu singleplayer")
        }))
        
        alert.addAction(UIAlertAction(title: "De 10 a 25 horas", style: .default, handler: { (_) in
            print("User escolheu multiplayer")
        }))
        
        alert.addAction(UIAlertAction(title: "De 25 a 35 horas", style: .default, handler: { (_) in
            print("User escolheu cooperativo")
        }))
        
        alert.addAction(UIAlertAction(title: "De 35 a 50 horas", style: .default, handler: { (_) in
            print("User escolheu cooperativo")
        }))
        
        alert.addAction(UIAlertAction(title: "Mais que 50 horas", style: .default, handler: { (_) in
            print("User escolheu cooperativo")
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
        editRadiusAlert.addAction(UIAlertAction(title: "Concluido", style: .default, handler: nil))
        editRadiusAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        //print(chosenMode)
        self.present(editRadiusAlert, animated: true)
    }
    
    

}
