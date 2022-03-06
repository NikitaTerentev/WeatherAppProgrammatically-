//
//  CoreDataService.swift
//  WeatherAppProgrammatically
//
//  Created by Nikita on 21.02.2022.
//

import UIKit
import CoreData


final class CoreDataManager {
    
    let context: NSManagedObjectContext
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
        
        
    }
    
    
    func saveCity(cityName: String, temp: Double) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Cities", in: context) else { return }
        
        let cityObject = Cities(entity: entity, insertInto: context)
        cityObject.cityName = cityName
        cityObject.cityLabel = temp

        context.performAndWait {
            do {
                try context.save()
            } catch {
                // Убрать принт(если нужна обработка ошибки - ее надо сделать)
                // + посмотри про context.rollback()
                context.rollback()
                //rollback - возвращает в дефолт и отменяет все изменения
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }

        }
    }

    func deleteCity1() {

        let fetchRequest: NSFetchRequest<Cities> = Cities.fetchRequest()

    
        if let cities = try? context.fetch(fetchRequest) {
            for city in cities {
                context.delete(city)
            }
        }
        context.performAndWait {
            do {
                try context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
      
    }
    
    func fetch() -> [Weather] {

        let fetchRequest: NSFetchRequest<Cities> = Cities.fetchRequest()
            do {
                let cities = try context.fetch(fetchRequest)
                return cities.map({Weather(name: $0.cityName ?? "", temp: $0.cityLabel)})
            } catch  {
                return []
            }
    }
    
    func getAllCitiesFetch(_ completionHandler: @escaping ([Weather]) -> Void) {
    
        context.perform {
            let cities = try? Cities.all(self.context)
            let weathers = cities?.map({Weather(city: $0, temp: $0.cityLabel)})

            completionHandler(weathers ?? [])

        }
    }
}
