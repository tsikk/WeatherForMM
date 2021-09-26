//
//  DailyWeatherViewController.swift
//  WeatherForMM
//
//  Created by Ilia Tsikelashvili on 26.09.21.
//

import UIKit
import CoreLocation

class DailyWeatherViewController : UIViewController {

    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var spinner   : UIActivityIndicatorView!
    
    private var dataSource: DailyWeatherDataSource!
    private var viewModel: DailyWeatherViewModelProtocol!
    private var dailyWeatherManager: DailyWeatherManagerProtocol!
    private var dailyWeatherData: DailyWeatherModel?
    
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = false
        tableView.isHidden = true
        spinner.startAnimating()
        configureVc()
        tableView.registerNib(class: DailyWeatherTableViewCell.self)
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

}

extension DailyWeatherViewController : CLLocationManagerDelegate {
    func configureVc() {
        viewModel = DailyWeatherViewModel(with: self)
        dailyWeatherManager = DailyWeatherManager()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue = manager.location else {return}
        dailyWeatherManager.fetchDailyWeather(controller:self,lat: "\(locValue.coordinate.latitude)", long: "\(locValue.coordinate.longitude)") {[weak self] dailyWeather in
            self?.dailyWeatherData = dailyWeather
            guard let dailyWeatherData = self?.dailyWeatherData else { return }
            DispatchQueue.main.async { [weak self] in
                self?.dataSource = DailyWeatherDataSource(with:(self?.tableView)!, dailyWeatherData: dailyWeatherData)
                self?.dataSource.createArrayForSections()
                self?.tableView.reloadData()
                self?.spinner.stopAnimating()
                self?.spinner.isHidden = true
                self?.tableView.isHidden = false
            }
        }
    }
}
