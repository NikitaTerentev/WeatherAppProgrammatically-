//
//  TableVC.swift
//  WeatherAppProgrammatically
//
//  Created by Nikita on 21.02.2022.
//

import UIKit
import CoreData

var coreDataStorage = [Cities]()
var cityTemps: [WeatherModel] = []


class TableVC: UITableViewController {
    

    private let jsonTask = APIManager()
    private var cityTemps: [WeatherModel] = []
    private let coreDataManaer = CoreDataManager()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        let weathers = coreDataManaer.fetch()
        cityTemps = weathers.map(WeatherModel.init(weather:))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSomeCity(_:)))
        tableView.reloadData()


    }
    
    @objc func addSomeCity(_ sender: UIBarButtonItem) {
        
        alert(onSelect: { [weak self] cityName in
            self?.jsonTask.getSomeCity(for: cityName) { result in

                DispatchQueue.main.async {
                    if let model = try? result.get() {
                        self?.coreDataManaer.saveCity(cityName: model.name, temp: model.main.temp)
                        self?.cityTemps.append(WeatherModel(weather: model))
                        self?.tableView.reloadData()
                    }
                }
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cityTemps.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.configure(with: cityTemps[indexPath.row].weather)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
       }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDel = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            self.cityTemps.remove(at: indexPath.row)
//            self.coreDataManaer.context.delete(Cities)

            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
        let actions = UISwipeActionsConfiguration(actions: [actionDel])
        return actions
    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            coreDataManaer.context.delete(cityTemps[indexPath.row]) as? Cities
//        }
//    }

}


