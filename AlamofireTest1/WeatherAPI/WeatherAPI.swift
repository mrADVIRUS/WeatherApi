//
//  WeatherAPI.swift
//  AlamofireTest1
//
//  Created by Sergiy Lyahovchuk on 23.06.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import UIKit
import Alamofire

class WeatherAPI {
//    var baseUrl: String! = "http://api.openweathermap.org/data/2.5/"
    
    //var CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=29655ff32ce718f0b398eba7f02f6a54"
    
    func fetchCurrentWeather(completed: @escaping weatherDetailsBlock) {
        let strWeatherUrl = "\(BASE_URL)\(METHOD_WEATHER)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"
        let weatherUrl = URL(string: strWeatherUrl)!
        print("WeatherURL = \(String(describing: weatherUrl))")
        
        Alamofire.request(weatherUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            guard response.result.isSuccess else {
                print("Error while fetching remote weather: \(String(describing: response.result.error))")
                completed(nil)
                return
            }
            
            if let json = response.result.value as? [String: AnyObject] {
                let currentWeatherDetails = CurrentWeatherModel(weatherDict: json)
                completed(currentWeatherDetails)
            } else {
                completed(nil)
            }
        }
    }
    
    func fetchForecast(completed: @escaping forecastListBlock) {
        let strForecastUrl = "\(BASE_URL)\(METHOD_FORECAST)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(COUNT)7\(APP_ID)\(API_KEY)"
        let forecastUrl = URL(string: strForecastUrl)!
        print("ForecastURL = \(String(describing: forecastUrl))")
        
        Alamofire.request(forecastUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<300).responseJSON { response in
            
            guard response.result.isSuccess else {
                print("Error while fetching tags: \(String(describing: response.result.error))")
                completed(nil)
                return
            }
            
            guard let responseJSON = response.result.value as? [String: AnyObject] else {
                print("Invalid tag information received from the service")
                completed(nil)
                return
            }
            
            var forecastsList = [ForecastModel]()
            
            if let lists = responseJSON["list"] as? [[String: AnyObject]] {
                //                print("JSON Forecats= \(lists)")
                for list in lists {
                    let forecast = ForecastModel(weatherDict: list)
                    forecastsList.append(forecast)
                    //                    print(list)
                }
            }
            
            completed(forecastsList)
        }
    }
}
