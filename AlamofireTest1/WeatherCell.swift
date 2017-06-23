//
//  WeatherCell.swift
//  AlamofireTest1
//
//  Created by Sergiy Lyahovchuk on 22.06.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var ivWeatherIcon: UIImageView!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblWeatherType: UILabel!
    @IBOutlet weak var lblHighTemp: UILabel!
    @IBOutlet weak var lblLowTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(forecast: ForecastModel) {
        if let lowT = Double(forecast.lowTemp), let highT = Double(forecast.heightTemp){
            lblLowTemp.text = "\(round((lowT - 32) * 5/9))C°"
            lblHighTemp.text = "\(round((highT - 32) * 5/9))C°"
        }
        
        lblWeatherType.text = forecast.weatherType
        lblDay.text = forecast.date
        ivWeatherIcon.image = UIImage(named:forecast.weatherType)
    }
    
}
