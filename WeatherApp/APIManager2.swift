//
//  APIManager2.swift
//  WeatherApp
//
//  Created by Panyushenko on 26.04.2018.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager2 {
    static let sharedInstance = APIManager2()
    
    let sessionManager = Alamofire.SessionManager.default
    
    func fetchCurrentWeatherWith(coordinates: Coordinates, completionHandler: @escaping (_ currentWeather: CurrentWeather) -> Void) {
        guard let url = URL(string:  "\(Constant.WeatherSite.url)\(Constant.WeatherSite.apiKey)/\(coordinates.latitude),\(coordinates.longitude)") else { return }
        //let parametrs = [:]()
        sessionManager.request(url, method: .get).responseJSON { (dataResponse) in
            switch dataResponse.result {
            case .success(let value):
                //guard let value = dataResponse.result.value else { return }
                let json = JSON(value)
                
                guard let temperature = json["currently"]["temperature"].double,
                let apparentTemperature = json["currently"]["apparentTemperature"].double,
                let humidity = json["currently"]["humidity"].double,
                let pressure = json["currently"]["pressure"].double,
                let iconString = json["currently"]["icon"].string,
                let timeZone = json["timezone"].string
                else { return }
                
                DispatchQueue.main.async {
                    guard let image = UIImage(named: iconString) else { return }
                    completionHandler(CurrentWeather(temperature: temperature, apparentTemperature: apparentTemperature, humidity: humidity, pressure: pressure, icon: image, timeZone: timeZone))
                    //completionHandler(CurrentWeather(temperature: temperature, apparentTemperature: apparentTemperature, humidity: humidity, pressure: pressure, icon: image))
                }
            case .failure(let error):
                print("\(error)")
            }
//            guard dataResponse.result.isSuccess else { return }
//            guard let value = dataResponse.result.value else { return }
//            let json = JSON(value)
//
//            guard let temperature = json["currently"]["temperature"].double,
//                let apparentTemperature = json["currently"]["apparentTemperature"].double,
//                let humidity = json["currently"]["humidity"].double,
//                let pressure = json["currently"]["pressure"].double,
//                let iconString = json["currently"]["icon"].string else { return }
//            DispatchQueue.main.async {
//                guard let image = UIImage(named: iconString) else { return }
//                completionHandler(CurrentWeather(temperature: temperature, apparentTemperature: apparentTemperature, humidity: humidity, pressure: pressure, icon: image))
//            }
        }
    }
}
