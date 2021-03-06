//
//  Weather.swift
//  Yandex Weather Test Api
//
//  Created by Roman Gorodilov on 08.08.2021.
//

import Foundation

struct Weather: Codable {
    
    let fact: Fact
    let forecasts: [Forecast]
}

struct Fact: Codable {
    
    let temp: Int
    let icon: String
    let condition: String
    let windSpeed: Double
    let windDir: String
    let pressureMm: Int
    
    private enum CodingKeys: String, CodingKey {
        
        case temp
        case icon
        case condition
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case pressureMm = "pressure_mm"
    }
}

struct Forecast: Codable {
    
    let parts: Parts
}

struct Parts: Codable {
    
    let day: Day
}

struct Day: Codable {
    
    let tempMin: Int?
    let tempMax: Int?
    
    private enum CodingKeys: String, CodingKey {
        
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
