//
//  Constants.swift
//  AlamofireTest1
//
//  Created by Sergiy Lyahovchuk on 22.06.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/"
let METHOD_WEATHER = "weather?"
let METHOD_FORECAST = "forecast/daily?"
let API_KEY = "29655ff32ce718f0b398eba7f02f6a54"
let APP_ID = "&appid="
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let COUNT = "&cnt="

//var CURRENT_WEATHER_URL = "\(BASE_URL)\(METHOD_WEATHER)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"
//var CURRENT_FORECAST_URL = "\(BASE_URL)\(METHOD_FORECAST)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(COUNT)10\(APP_ID)\(API_KEY)"

typealias DownloadComplete = () -> ()
typealias CompletionBlock = (NSData?, NSError?) -> ()
typealias weatherDetailsBlock = (CurrentWeatherModel?) -> ()
typealias forecastListBlock = ([ForecastModel]?) -> ()
