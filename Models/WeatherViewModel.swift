//
//  WeatherViewModel.swift
//  WeatherAppProgrammatically
//
//  Created by Nikita on 21.02.2022.
//

import Foundation


class WeatherModel {
    let  weather: Weather
    
    init(weather: Weather) {
        self.weather = weather
    }
    
    var nameString: String {
        return String(weather.name)
    }
    
    
    var temrepatureString: String {
        return String(weather.main.temp)

    }
}
