//
//  CurrentWeather.swift
//  AlamofireTest1
//
//  Created by Sergiy Lyahovchuk on 22.06.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeatherAPI {
    private var _cityName: String!
    private var _date: String!
    private var _weatherType:String!
    private var _currentTemp: Double!

    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        _date = "Today, \(currentDate)"
        
        return _date
    }
    
    func downloadWeaterDetails(completed: @escaping DownloadComplete) {
        //Alamofire downloas
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        
        print("WeatherURL = \(currentWeatherURL.absoluteString)")
        
        Alamofire.request(currentWeatherURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")
            
            guard response.result.isSuccess else {
                print("Error while fetching remote weather: \(String(describing: response.result.error))")
                completed()
                return
            }
            
            
            let json = response.result.value as? [String: AnyObject]
            
            guard json != nil else {
                    print("Malformed data received from fetchAllRooms service")
                    completed()
                    return
            }
            
//            print("JSON: \(String(describing: json))") // serialized json response
            print("-------------")
            
            if  let name = json?["name"] as? String {
                self._cityName = name.capitalized
                print("City: \(self._cityName)")
            }
            
            if let weather = json?["weather"] as? [[String: AnyObject]] {
                if weather.count > 0, let weatherType = weather[0]["main"] as? String {
                    self._weatherType = weatherType.capitalized
//                    print("WeatherType: \(self._weatherType)")
                }
            }
            
            if let main = json?["main"] as? [String: AnyObject] {
                if let temp = main["temp"] as? Double {
                    self._currentTemp = round((temp * 9/5) - 459.67)
//                    print("CurrentTemp: \(self._currentTemp)")
                }
            }
            
            completed()
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)") // original server data as UTF8 string
//            }
            
            
        }
    }
}
