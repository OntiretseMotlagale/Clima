//
//  WeatherManager.swift
//  Clima
//
//  Created by Ontiretse Motlagale on 2023/01/24.
//

import Foundation
import UIKit

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}



struct WeatherManager {
    
    var URL = "https://api.openweathermap.org/data/2.5/weather?=&appid=8c30dbc77249a4fd2eedddeb60388cd1&units=metric"
    
    func fetchCity(cityName: String) {
        let urlString = "\(URL)&q=\(cityName)"
        
        performRequest(urlString: urlString)
    }
    
    var delegate: WeatherManagerDelegate?
    
    func performRequest(urlString: String){
        
        if let url = Foundation.URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather = parseJSON(weatherData: safeData){
                        delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            task.resume()
        }
        
            func parseJSON(weatherData: Data) -> WeatherModel? {
                let decoder = JSONDecoder()
                do {
                   let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
                    let temp = decodeData.main.temp
                    let id = decodeData.weather[0].id
                    let cityName = decodeData.name
                    let description = decodeData.weather[0].description
                    
                    let weather = WeatherModel(conditionId: id, cityName: cityName, description: description, temperature: temp)
               
                    print(weather.temperature)
                    return weather
                }
                catch {
                    print(error)
                    return nil
                }
            }
    }
}
