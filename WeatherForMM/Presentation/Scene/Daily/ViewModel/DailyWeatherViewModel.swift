//
//  DailyWeatherViewModel.swift
//  WeatherForMM
//
//  Created by Ilia Tsikelashvili on 26.09.21.
//

import UIKit
import CoreLocation

protocol DailyWeatherViewModelProtocol: AnyObject {
    
    init(with viewcontroller: UIViewController)
        
}

final class DailyWeatherViewModel: DailyWeatherViewModelProtocol {
    
    private weak var controller: UIViewController?
    
    init(with viewcontroller: UIViewController) {
        
        self.controller = viewcontroller
    
    }

}
