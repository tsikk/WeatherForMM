//
//  CurrentWeatherViewController.swift
//  WeatherForMM
//
//  Created by Ilia Tsikelashvili on 26.09.21.
//

import UIKit
import CoreLocation

class CurrentWeatherViewController: UIViewController {

    private var viewModel: CurrentWeatherViewModelProtocol!
    private var currentWeatherManager: CurrentWeatherManagerProtocol!
    private var shareString: String?
    let locationManager = CLLocationManager()

    @IBOutlet weak var firstHidden: UIStackView!
    @IBOutlet weak var secondHidden: UIStackView!
    
    @IBOutlet weak var humidityPercent : UILabel!
    @IBOutlet weak var currentWeather  : UILabel!
    @IBOutlet weak var currentLocation : UILabel!
    @IBOutlet weak var rainFall        : UILabel!
    @IBOutlet weak var preasureLabel   : UILabel!
    @IBOutlet weak var windSpeedLabel  : UILabel!
    @IBOutlet weak var windDirection   : UILabel!
    
    @IBOutlet weak var bigCircleImg    : UIImageView!
    @IBOutlet weak var windImg         : UIImageView!
    @IBOutlet weak var compassImg      : UIImageView!
    @IBOutlet weak var preasureImg     : UIImageView!
    @IBOutlet weak var dropletImg      : UIImageView!
    @IBOutlet weak var rainyCloudImg   : UIImageView!
    
    @IBOutlet weak var shareBtn        : UIButton!
    
    @IBOutlet weak var secondStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareBtn.isHidden = true
        configureViewModel()
        viewModel.setUpDarkMode(with: self.view)
        setUpImages()
        setUpVc()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(orientationDidChange(_:)),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleOrientationChange()
    }
    
    @objc private func orientationDidChange( _ sender: Any) {
        handleOrientationChange()
    }
    
    private func handleOrientationChange() {
        if UIDevice.current.orientation.isLandscape {
            secondStackView.isHidden = true
            firstHidden.isHidden = false
            secondHidden.isHidden = false
        } else {
            secondStackView.isHidden = false
            firstHidden.isHidden = true
            secondHidden.isHidden = true
        }
        updateViewConstraints()
    }
    
    @IBAction func onShare(_ sender: Any) {
        guard let text = shareString else {return}
        let item = [text]
        let ac = UIActivityViewController(activityItems: item, applicationActivities: nil)
        present(ac, animated: true, completion: nil)
    }
    
}

extension CurrentWeatherViewController : CLLocationManagerDelegate {
    
    func getShreText(temp:Int,
                     description: String,
                     location: String,
                     country: String) -> String {
        return "\(temp)° | \(description), \(location), \(country) by WeatherApp"
    }
    
    func configureViewModel() {
        viewModel = CurrentWeatherViewModel(with: self)
        currentWeatherManager = CurrentWeatherManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func setUpImages() {
        viewModel.setUpIconDarkMode(with: rainyCloudImg,
                                    firstColor: .systemYellow,
                                    secondColor: .yellow)
        viewModel.setUpIconDarkMode(with: dropletImg,
                                    firstColor: .systemYellow,
                                    secondColor: .yellow)
        viewModel.setUpIconDarkMode(with: preasureImg,
                                    firstColor: .systemYellow,
                                    secondColor: .yellow)
        viewModel.setUpIconDarkMode(with: windImg,
                                    firstColor: .systemYellow,
                                    secondColor: .yellow)
    }
    
    func setUpVc() {
        guard let tabBaritems = tabBarController?.tabBar.items else {return}
        tabBaritems[0].title = "Today"
        tabBaritems[0].image = UIImage(named: "sun")
        tabBaritems[1].title = "Forecast"
        tabBaritems[1].image = UIImage(named: "sunny_cloud")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue = manager.location else {return}
        UIView.animate(withDuration: 3) { [unowned self] in
            self.shareBtn.isHidden = false
        }
        currentWeatherManager.fetchCurrentWeather(controller:self, lat: "\(locValue.coordinate.latitude)", long: "\(locValue.coordinate.longitude)") { [weak self] currentWeather in
            DispatchQueue.main.async {
                guard let strongself = self else {return}
                strongself.viewModel.manageUI(with: currentWeather,
                                              mainPhoto: strongself.bigCircleImg ,
                                              currentLocation: strongself.currentLocation,
                                              currentTemp: strongself.currentWeather,
                                              humidityLabel: strongself.humidityPercent,
                                              preasureLabel: strongself.preasureLabel,
                                              windSpeedLabel: strongself.windSpeedLabel,
                                              windDirecction: strongself.windDirection)
                strongself.shareString = strongself.getShreText(temp: Int(( currentWeather.main.temp ) - 273.15),
                                                                description: currentWeather.weather.first?.weatherDescription ?? "",
                                                                location: currentWeather.name,
                                                                country: currentWeather.sys.country)
            }
        }
    }
}
