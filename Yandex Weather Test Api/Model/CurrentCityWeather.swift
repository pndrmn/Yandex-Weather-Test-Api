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
    var condition: String = ""
    var windSpeed: Double = 0.0
    var windDir: String = ""
    var pressureMm: Int = 0
    var tempMin: Int = 0
    var tempMax: Int = 0
    var daytime: String = ""
    
    var conditionEmoji: String{
        
        switch condition {
        
        case "clear":
            switch daytime {
            case "d":
                return "☀️"
            case "n":
                return "🌙"
            default:
                return "☀️"
            }
        case "partly-cloudy":
            switch daytime {
            case "d":
                return "🌤"
            case "n":
                return "☁️"
            default:
                return "🌤"
            }
        case "cloudy":
            switch daytime {
            case "d":
                return "⛅️"
            case "n":
                return "☁️"
            default:
                return "⛅️"
            }
        case "overcast":
            return "☁️"
        case "drizzle":
            return "💦"
        case "light-rain":
            switch daytime {
            case "d":
                return "🌦"
            case "n":
                return "🌧"
            default:
                return "🌦"
            }
        case "rain", "moderate-rain", "heavy-rain", "continuous-heavy-rain", "showers":
            return "🌧"
        case "wet-snow":
            return "🌨"
        case "light-snow", "snow", "snow-showers":
            return "❄️"
        case "hail":
            return "🌨"
        case "thunderstorm":
            return "🌩"
        case "thunderstorm-with-rain", "thunderstorm-with-hail":
            return "⛈"
        default:
            return ""
        }
    }
    
    init?(weather: Weather) {
        
        temp = weather.fact.temp
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
