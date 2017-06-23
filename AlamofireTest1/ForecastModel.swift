//
//  Forecast.swift
//  AlamofireTest1
//
//  Created by Sergiy Lyahovchuk on 22.06.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import UIKit
import Alamofire

class ForecastModel {
    private var _date: String!
    private var _weatherType: String!
    private var _hightTemp: String!
    private var _lowTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var heightTemp: String {
        if _hightTemp == nil {
            _hightTemp = ""
        }
        return _hightTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict: [String: AnyObject]) {
        if let temp = weatherDict["temp"] as? [String: AnyObject] {
            if let min = temp["min"] as? Double, let max = temp["max"] as? Double {
                _lowTemp = "\(round((min * 9/5) - 459.67))"
                _hightTemp = "\(round((max * 9/5) - 459.67))"
            }
        }
        
        if let weather = weatherDict["weather"] as? [[String: AnyObject]] {
            if weather.count > 0 {
                let main = weather[0]["main"] as? String
                _weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            _date = unixConvertedate.dayOfTheWeek()
        }
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
}
