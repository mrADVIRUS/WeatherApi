//
//  WeatherVC.swift
//  AlamofireTest1
//
//  Created by Sergiy Lyahovchuk on 21.06.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var ivCurrentWeather: UIImageView!
    @IBOutlet weak var lblCurrentWeatherType: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var forecastsList: [ForecastModel] = []
    var weatherAPI: WeatherAPI!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherAPI = WeatherAPI()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 1000
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: - Action
    
    @IBAction func onReload(sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - Private
    
    func updateWeatherDetails(weatherModel: CurrentWeatherModel?) {
        guard let weather = weatherModel else {
            print("Weather Details - nil")
            return
        }
        
        lblDate.text = weather.date
        lblCurrentTemp.text = "\(weather.currentTemp)F° \\\n\(round((weather.currentTemp - 32) * 5/9)) C°"
        lblLocation.text = weather.cityName
        lblCurrentWeatherType.text = weather.weatherType
        ivCurrentWeather.image = UIImage(named: weather.weatherType)
    }
    
    //MARK: - UITableViewDataSource, UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecastsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            cell.configureCell(forecast: self.forecastsList[indexPath.row])
            return cell
        } else {
            return WeatherCell()
        }
    }
 
    //MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Authorization status changed to \(status.rawValue)")
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let errorType = error._code == CLError.denied.rawValue ? "Access Denied" : "Error\(error._code)"
        let alertController = UIAlertController(title: "Location Manager Error", message: errorType, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(actionOk)
        present(alertController, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            print("Didn't come any locations!!!")
            return
        }
        print("LAT:\(location.coordinate.latitude) Lon:\(location.coordinate.longitude)")
        Location.sharedInstance.latitude = location.coordinate.latitude
        Location.sharedInstance.longitude = location.coordinate.longitude
        locationManager.stopUpdatingLocation()
//        print("LocationManager Coord: LAT[\(Location.sharedInstance.latitude!)] LON[\(Location.sharedInstance.longitude!)]")
        
        weatherAPI.fetchCurrentWeather { (response) in
            print("Done fetchCurrentWeather")
            DispatchQueue.main.async {
                self.updateWeatherDetails(weatherModel: response)
            }
        }
        
        weatherAPI.fetchForecast { (response) in
            print("Done fetchForecast")
            self.forecastsList = response ?? []
            self.tableView.reloadData()
        }
    }
}
