//
//  CityTableViewCell.swift
//  Yandex Weather Test Api
//
//  Created by Roman Gorodilov on 08.08.2021.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    let cityLabel = UILabel()
    let weatherLabel = UILabel()
    let temperatureLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        disableTranslatesAutoresizingMaskIntoConstraints()
        configureTextAlignment()
        addSubviews ()
        addLayoutConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func disableTranslatesAutoresizingMaskIntoConstraints() {
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTextAlignment() {
        
        cityLabel.textAlignment = .left
        weatherLabel.textAlignment = .right
        temperatureLabel.textAlignment = .right
    }
    
    private func addSubviews() {
        
        contentView.addSubview(cityLabel)
        contentView.addSubview(weatherLabel)
        contentView.addSubview(temperatureLabel)
    }
    
    private func addLayoutConstraint() {
        
        NSLayoutConstraint.activate([
            
            cityLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant:10),
            cityLabel.widthAnchor.constraint(equalToConstant: 250),
            cityLabel.heightAnchor.constraint(equalToConstant: 40),
            
            weatherLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            weatherLabel.leadingAnchor.constraint(equalTo: self.cityLabel.trailingAnchor, constant: 10),
            weatherLabel.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor, constant: -10),
            weatherLabel.heightAnchor.constraint(equalToConstant: 40),
            
            temperatureLabel.widthAnchor.constraint(equalToConstant: 60),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 40),
            temperatureLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            temperatureLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    
    func configureCell(weather: CurrentCityWeather) {
        
        if weather.city == "" {
            cityLabel.text = "Loading"
        } else {
            cityLabel.text = weather.city
            weatherLabel.text = weather.conditionEmoji
            temperatureLabel.text = "\(String(weather.temp))℃"
        }
    }
}
