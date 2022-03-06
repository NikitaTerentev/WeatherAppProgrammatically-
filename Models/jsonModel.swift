//
//  jsonModel.swift
//  WeatherAppProgrammatically
//
//  Created by Nikita on 21.02.2022.
//

import Foundation

struct Weather: Decodable {
    var name: String
    var main: Main

    struct Main: Decodable {
        var temp: Double
        var feelsLike: Double
        var tempMin: Double
        var tempMax: Double
        var pressure: Double
        var humidity: Double
        
        init(temp: Double) {
            self.temp = temp
            self.feelsLike = 0
            self.tempMin = 0
            self.tempMax = 0
            self.pressure = 0
            self.humidity = 0
            
        }

        enum CodingKeys: String, CodingKey {
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case temp
            case pressure
            case humidity
        }
    }
    
    init(name: String, temp: Double) {
        self.name = name
        main = Main(temp: temp)
        
    }

    init(city: Cities, temp: Double) {
        self.name = city.cityName ?? ""
        main = Main(temp: temp)
        main.temp = city.cityLabel

        


        
    }
}

