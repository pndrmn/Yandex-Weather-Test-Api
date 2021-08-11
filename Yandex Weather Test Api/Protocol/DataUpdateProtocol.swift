//
//  DataUpdate.swift
//  Yandex Weather Test Api
//
//  Created by Roman Gorodilov on 11.08.2021.
//

import Foundation

protocol DataUpdateProtocol {
    
    func onDataUpdate(data: CurrentCityWeather)
}
