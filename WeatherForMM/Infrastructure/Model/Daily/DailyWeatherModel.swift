//
//  DailyWeatherModel.swift
//  WeatherForMM
//
//  Created by Ilia Tsikelashvili on 26.09.21.
//

import Foundation

// MARK: - DailyWeatherModel
struct DailyWeatherModel: Codable {
    let cod: String
    let message, cnt: Int
    let list: [DailyList]
    let city: DailyCity
}

// MARK: - DailyCity
struct DailyCity: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - DailyCoord
struct DailyCoord: Codable {
    let lat, lon: Double
}

// MARK: - DailyList
struct DailyList: Codable {
    let dt: Int
    let main: DailyMainClass
    let weather: [WeatherModel]
    let clouds: DailyClouds
    let wind: DailyWind
    let visibility: Int
    let pop: Double
    let rain: DailyRain?
    let sys: DailySys
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - DailyClouds
struct DailyClouds: Codable {
    let all: Int
}

// MARK: - DailyMainClass
struct DailyMainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - DailyRain
struct DailyRain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - DailySys
struct DailySys: Codable {
    let pod: DailyPod
}

enum DailyPod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let id: Int
    let main: MainEnum
    let weatherDescription: Description
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

// MARK: - DailyWind
struct DailyWind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}
