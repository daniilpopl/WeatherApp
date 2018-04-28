//
//  Weather5DaysViewController.swift
//  WeatherApp
//
//  Created by cidr5 on 4/28/18.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import UIKit
import CoreLocation

class Weather5DaysViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    let locationManager = CLLocationManager()
    lazy var weatherManager = APIWeatherManager(apiKey: "2a6d8e376a69c1ae07d4a52dd0c2dfdc")
    let coordinates = Coordinates(latitude: 53.917950, longitude: 27.561776)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        Date().timeIntervalSince1970 + 86400
        
        //fetchWeatherData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchWeatherData() {
        weatherManager.fetchCurrentWeatherWith(coordinates: coordinates) { (result) in
            self.toggleActivityIndicator(false)
            
            switch result {
            case .Success(let weather):
                let a = weather
            case .Failure(let error as NSError):
                
                let alertController = UIAlertController(title: "Unable to get data ", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            default: break
            }
        }
    }
    
    func toggleActivityIndicator(_ on: Bool) {
        refreshButton.isHidden = on
        on ? loader.startAnimating() : loader.stopAnimating()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
