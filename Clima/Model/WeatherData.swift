//
//  WeatherData.swift
//  Clima
//
//  Created by Ontiretse Motlagale on 2023/01/24.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let description: String
    
}
