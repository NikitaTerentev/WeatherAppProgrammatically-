//
//  Protocols.swift
//  WeatherAppProgrammatically
//
//  Created by Nikita on 21.02.2022.
//

import Foundation


enum APIErrors: Error {
    case noData
    case invalidURL
    case undefined
}

protocol ProtocolCoreData {
//    var coreDataService: CoreDataManager { get }
    func saveCity(cityName: String, temp: Double)
    func deleteCity()
    func fetch() -> [Weather]
}

protocol APIService {
    
    func getSomeCity(for cityName: String, _ completion: @escaping ((Result<Weather, APIErrors>) -> Void))
    
//    var apiService: APIManager { get }
}

//struct AppDependency: ProtocolCoreData, APIService {
//
//    var coreDataService: CoreDataManager
//    var apiService: APIManager
//
//}
