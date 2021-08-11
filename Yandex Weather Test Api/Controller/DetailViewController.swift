//
//  DetailViewController.swift
//  Yandex Weather Test Api
//
//  Created by Roman Gorodilov on 08.08.2021.
//

import SVGKit
import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    var currentWeather: CurrentCityWeather!
    
    var handleUpdatedDataDelegate: DataUpdateProtocol?
    
    var isContain = false
    
    let network = Network()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = currentWeather.city
        label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(currentWeather.temp)℃"
        label.font = UIFont.systemFont(ofSize: 70)
        return label
    }()
    
    private lazy var conditionImageView: UIImageView = {
        
        let imageView = UIImageView()
        network.showSVG(view: imageView, weather: currentWeather)
        return imageView
    }()
    
    private lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Minimum temperature: \(currentWeather.tempMin)℃"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Maximum temperature: \(currentWeather.tempMax)℃"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Wind: \(currentWeather.windDir.uppercased()) \(currentWeather.windSpeed) m/s"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var pressureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Atm. pressure: \(currentWeather.pressureMm) mm"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var condition: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Weather conditions: \(currentWeather.condition.replacingOccurrences(of: "-", with: " ").firstUppercased)"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Yandex Weather"
        view.backgroundColor = .white
        
        if !isContain {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addSelectedCity))
        }
        
        addSubviews()
        addConstraintsToSubviews()
    }
    
    //MARK: - Functions
    private func addSubviews() {
        [cityLabel, conditionImageView, tempLabel, minTempLabel, maxTempLabel, windLabel, pressureLabel, condition].forEach {view.addSubview($0)}
    }
    
    private func addConstraintsToSubviews() {
        
        NSLayoutConstraint.activate([
            
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            conditionImageView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 35),
            conditionImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            conditionImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            conditionImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
            conditionImageView.heightAnchor.constraint(equalTo: conditionImageView.widthAnchor, multiplier: 2/3),
            
            tempLabel.topAnchor.constraint(equalTo: conditionImageView.bottomAnchor,constant: 35),
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            minTempLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 100),
            minTempLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            
            maxTempLabel.topAnchor.constraint(equalTo: minTempLabel.bottomAnchor, constant: 15),
            maxTempLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            
            windLabel.topAnchor.constraint(equalTo: maxTempLabel.bottomAnchor, constant: 15),
            windLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            
            pressureLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: 15),
            pressureLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            
            condition.topAnchor.constraint(equalTo: pressureLabel.bottomAnchor, constant: 15),
            condition.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15)
        ])
    }
    
    @objc func addSelectedCity() {
        
        guard let updatedData = currentWeather else {
            return
        }
        handleUpdatedDataDelegate?.onDataUpdate(data: updatedData)
        navigationController?.popViewController(animated: true)
    }
}
