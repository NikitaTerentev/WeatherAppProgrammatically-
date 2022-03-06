//
//  Cities+CoreDataClass.swift
//  WeatherAppProgrammatically
//
//  Created by Nikita on 21.02.2022.
//
//

import Foundation
import CoreData

@objc(Cities)
public class Cities: NSManagedObject {
    
    class func findOrCreate(_ weather: Weather, context: NSManagedObjectContext) throws -> Cities {
        let request: NSFetchRequest<Cities> = Cities.fetchRequest()
        request.predicate = NSPredicate(format: "name == %n", weather.name)
        
        do {
            let fetchResult = try context.fetch(request)
            if fetchResult.count > 0 {
                assert(fetchResult.count == 1, "Duplicate has been found in DB ")
                return fetchResult[0]
            }
        } catch  {
            throw error
        }
        let cities = Cities(context: context)
        cities.cityName = weather.name
        cities.cityLabel = weather.main.temp
        
        return cities
    }
    
    
    class func all(_ context: NSManagedObjectContext) throws -> [Cities] {
        let request: NSFetchRequest<Cities> = Cities.fetchRequest()
        do {
            return try context.fetch(request)
            
        } catch {
            throw error
        }
    }
}
