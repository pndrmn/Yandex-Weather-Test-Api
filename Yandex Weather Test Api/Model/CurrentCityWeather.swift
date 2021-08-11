//
//  CurrentCityWeather.swift
//  Yandex Weather Test Api
//
//  Created by Roman Gorodilov on 08.08.2021.
//

import Foundation

struct CurrentCityWeather {
    
    var city: String = ""
    var temp: Int = 0
    var icon: String = ""
    var condition: String = ""
    var windSpeed: Double = 0.0
    var windDir: String = ""
    var pressureMm: Int = 0
    var tempMin: Int = 0
    var tempMax: Int = 0
    var daytime: String = ""
    
    init?(weather: Weather) {
        
        temp = weather.fact.temp
        icon = weather.fact.icon
        condition = weather.fact.condition
        windSpeed = weather.fact.windSpeed
        windDir = weather.fact.windDir
        pressureMm = weather.fact.pressureMm
        tempMin = weather.forecasts.first!.parts.day.tempMin!
        tempMax = weather.forecasts.first!.parts.day.tempMax!
        daytime = weather.forecasts.first!.parts.day.daytime
    }
    
    init() {
    }
}
