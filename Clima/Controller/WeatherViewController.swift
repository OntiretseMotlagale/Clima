//
//  ViewController.swift
//  Clima
//
//  Created by Ontiretse Motlagale on 2023/01/23.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
   
    

    
    @IBOutlet var searchField: UITextField!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherManager.delegate = self
        searchField.delegate = self
        
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //What happens when the return button on the keyboard is pressed
        searchField.endEditing(true)
        print(searchField.text!)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else {
            textField.placeholder = "Type Something..."
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
      
        if let city = searchField.text {
            weatherManager.fetchCity(cityName: city)
        }
        
        searchField.text = ""
       
    }
    @IBAction func searchPressed(_ sender: UIButton) {
        if let city = searchField.text {
            weatherManager.fetchCity(cityName: city)
        }
        
        searchField.text = ""
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.descriptionLabel.text = weather.description
            self.conditionImageView.image = UIImage(systemName: weather.getWeatherCondition)
            self.temperatureLabel.text = weather.temperatureString
        }
    }
}

