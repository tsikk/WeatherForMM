//
//  CurrentWeatherViewModel.swift
//  WeatherForMM
//
//  Created by Ilia Tsikelashvili on 26.09.21.
//

import UIKit
import Kingfisher

protocol CurrentWeatherViewModelProtocol: AnyObject {
    init(with viewcontroller: UIViewController)
    
    func setUpDarkMode(with view: UIView)
    func setUpTextDarkMode(with label: UILabel, firstColor: UIColor, secondColor: UIColor)
    func setUpIconDarkMode(with imageView: UIImageView, firstColor: UIColor, secondColor: UIColor)
    func manageUI(with weather: CurrentWeatherModel, mainPhoto: UIImageView, currentLocation: UILabel, currentTemp: UILabel, humidityLabel: UILabel, preasureLabel: UILabel, windSpeedLabel: UILabel, windDirecction: UILabel)
}

final class CurrentWeatherViewModel: CurrentWeatherViewModelProtocol {
    
    private weak var controller: UIViewController?
        
    init(with viewcontroller: UIViewController) {
        self.controller = viewcontroller
    }
    
    
    func setUpDarkMode(with view: UIView) {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemGray6
        } else {
            view.backgroundColor = .white
        }
    }
        
    func setUpTextDarkMode(with label: UILabel,
                           firstColor: UIColor,
                           secondColor: UIColor) {
        if #available(iOS 13.0, *) {
            label.textColor = firstColor
        } else {
            label.textColor = secondColor
        }
    }
    
    func setUpIconDarkMode(with imageView: UIImageView,
                           firstColor: UIColor,
                           secondColor: UIColor) {
        if #available(iOS 13.0, *) {
            imageView.tintColor = firstColor
        } else {
            imageView.tintColor = secondColor
        }
    }
    
    func manageUI(with weather: CurrentWeatherModel,
                  mainPhoto: UIImageView,
                  currentLocation: UILabel,
                  currentTemp: UILabel,
                  humidityLabel: UILabel,
                  preasureLabel: UILabel,
                  windSpeedLabel: UILabel,
                  windDirecction: UILabel) {
        let url = URL(string: "https://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png")
        
        mainPhoto.kf.setImage(with: url)
        currentLocation.text = "\(weather.name),\(weather.sys.country)"
        currentTemp.text = "\(Int(weather.main.temp - 273.15))° | \(weather.weather[0].weatherDescription) "
        humidityLabel.text = "\(weather.main.humidity) %"
        preasureLabel.text = "\(weather.main.pressure) hPa"
        windSpeedLabel.text = "\(weather.wind.speed) km/h"
        windDirecction.text = "\(checkDirection(degree: weather.wind.deg))"
        
    }
    
    func checkDirection(degree: Int) -> String {
        if degree >= 0 && degree < 30 {
            return "N"
        } else if degree >= 30 && degree <= 60 {
            return "NE"
        } else if degree > 60 && degree < 120 {
            return "E"
        } else if degree >= 120 && degree <= 150 {
            return "SE"
        } else if degree > 150 && degree < 210 {
            return "S"
        } else if degree >= 210 && degree <= 240 {
            return "SW"
        } else if degree > 240 && degree < 300 {
            return "W"
        } else if degree >= 300 && degree <= 330 {
            return "NW"
        } else if degree > 330 && degree < 360 {
            return "N"
        }
        return "_"
    }
}
