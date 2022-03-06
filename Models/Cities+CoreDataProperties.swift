//
//  Cities+CoreDataProperties.swift
//  WeatherAppProgrammatically
//
//  Created by Nikita on 21.02.2022.
//
//

import Foundation
import CoreData


extension Cities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cities> {
        return NSFetchRequest<Cities>(entityName: "Cities")
    }

    @NSManaged public var cityName: String?
    @NSManaged public var cityLabel: Double

}

extension Cities : Identifiable {

}
