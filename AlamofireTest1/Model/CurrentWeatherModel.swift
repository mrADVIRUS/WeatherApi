//
//  CurrentWeatherModel.swift
//  AlamofireTest1
//
//  Created by Sergiy Lyahovchuk on 23.06.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import Foundation

class CurrentWeatherModel {
    
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
    
    init(weatherDict: [String: AnyObject]) {
         if  let name = weatherDict["name"] as? String {
            self._cityName = name.capitalized
            print("City: \(self._cityName)")
        }
        
        if let weather = weatherDict["weather"] as? [[String: AnyObject]] {
            if weather.count > 0, let weatherType = weather[0]["main"] as? String {
                self._weatherType = weatherType.capitalized
                //                    print("WeatherType: \(self._weatherType)")
            }
        }
        
        if let main = weatherDict["main"] as? [String: AnyObject] {
            if let temp = main["temp"] as? Double {
                self._currentTemp = round((temp * 9/5) - 459.67)
                //                    print("CurrentTemp: \(self._currentTemp)")
            }
        }
    }
}
