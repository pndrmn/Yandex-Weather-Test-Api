//
//  CityTableViewCell.swift
//  Yandex Weather Test Api
//
//  Created by Roman Gorodilov on 08.08.2021.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    let cityLabel = UILabel()
    let weatherImageView = UIImageView()
    let temperatureLabel = UILabel()
    let network = Network()

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
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTextAlignment() {
        
        cityLabel.textAlignment = .left
//        weatherLabel.textAlignment = .right
        temperatureLabel.textAlignment = .right
    }
    
    private func addSubviews() {
        
        contentView.addSubview(cityLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(temperatureLabel)
    }
    
    private func addLayoutConstraint() {
        
        NSLayoutConstraint.activate([
            
            cityLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant:10),
            cityLabel.widthAnchor.constraint(equalToConstant: 250),
            cityLabel.heightAnchor.constraint(equalToConstant: 40),
            
            weatherImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: self.cityLabel.trailingAnchor, constant: 10),
            weatherImageView.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor, constant: -10),
            weatherImageView.heightAnchor.constraint(equalToConstant: 40),
            
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
            
            network.showSVG(view: weatherImageView, weather: weather)
            
            temperatureLabel.text = "\(String(weather.temp))???"
        }
    }
}
