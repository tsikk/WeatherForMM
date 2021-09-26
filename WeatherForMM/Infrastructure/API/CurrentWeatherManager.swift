//
//  CurrentWeatherManager.swift
//  WeatherForMM
//
//  Created by Ilia Tsikelashvili on 26.09.21.
//

import CoreLocation
import Foundation
import UIKit

protocol CurrentWeatherManagerProtocol: AnyObject {
    func fetchCurrentWeather(controller: UIViewController, lat: String, long: String, completion: @escaping ((CurrentWeatherModel) -> Void))
}

class CurrentWeatherManager: CurrentWeatherManagerProtocol {

    func fetchCurrentWeather(controller: UIViewController,lat: String, long: String, completion: @escaping ((CurrentWeatherModel) -> Void)) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=8f20dce1cb8568bef98332f9e23996fc"
        NetworkManager.shared.get(url: url) { (result: Result<(CurrentWeatherModel), Error>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Oops..", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    controller.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
