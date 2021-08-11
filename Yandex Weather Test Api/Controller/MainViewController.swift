//
//  MainViewController.swift
//  Yandex Weather Test Api
//
//  Created by Roman Gorodilov on 08.08.2021.
//

import UIKit

class MainViewController: UIViewController, DataUpdateProtocol {
    
    // MARK: - Properties
    let network = Network()
    let emptyWeather = CurrentCityWeather()
    
    var citiesArray = Cities().arrayOfCities
    var weatherArray = [CurrentCityWeather]()
    var filteredWeatherArray = [CurrentCityWeather]()
    var updatedData: CurrentCityWeather!
    
    var searchBarIsEmpty: Bool {
        guard let searchText = searchController.searchBar.text else {
            return false
        }
        return searchText.isEmpty
    }
    
    var isFiltering: Bool {
        
        return searchController.isActive && !searchBarIsEmpty
    }
    
    lazy var searchController: UISearchController = {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "cityCell")
        return tableView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Yandex Weather"
        view.backgroundColor = .white
        
        addNotificationCenter()
        
        addTableView()
        addConstraintsToSubview()
        configureSearcController()
        
        if weatherArray.isEmpty {
            weatherArray = Array(repeating: emptyWeather, count: citiesArray.count)
        }
        
        fillWeatherArray()
    }
    
    // MARK: - Table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if isFiltering {

            showDetailViewController(weather: filteredWeatherArray[indexPath.row], city: filteredWeatherArray[indexPath.row].city)
        } else {
            
            showDetailViewController(weather: weatherArray[indexPath.row], city: weatherArray[indexPath.row].city)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            if isFiltering {
                filteredWeatherArray.remove(at: indexPath.row)
            } else {
                citiesArray.remove(at: indexPath.row)
                weatherArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        reloadTableView()
    }
    //MARK: - Functions
    
    private func addTableView() {
        
        view.addSubview(tableView)
    }
    
    private func addConstraintsToSubview() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fillWeatherArray() {

        network.getWeatherFor(cities: citiesArray) { [weak self] index, weather in
            
            self?.weatherArray[index] = weather
            self?.weatherArray[index].city = self!.citiesArray[index]
            
            self?.reloadTableView()
        }
    }
    
    private func addNotificationCenter() {
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            tableView.contentInset = .zero
        } else {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        tableView.scrollIndicatorInsets = tableView.contentInset
    }
    
    func showAC() {
        
        let ac = UIAlertController(title: "City not found", message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        ac.addAction(okButton)
        self.present(ac, animated: true)
    }
    
    private func configureSearcController() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func showDetailViewController(weather: CurrentCityWeather, city: String!) -> Void {
        
        DispatchQueue.main.async {
            
            let detailViewController = DetailViewController()
            
            detailViewController.currentWeather = weather
            detailViewController.currentWeather.city = city
            
            if self.citiesArray.contains(weather.city) {
                detailViewController.isContain = true
            }
            
            detailViewController.handleUpdatedDataDelegate = self
            
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    func reloadTableView() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func onDataUpdate(data: CurrentCityWeather) {
        
        updatedData = data
        weatherArray.append(updatedData)
        citiesArray.append(updatedData.city)
        reloadTableView()
    }
}
