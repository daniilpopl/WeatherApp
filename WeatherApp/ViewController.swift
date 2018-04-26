//
//  ViewController.swift
//  WeatherApp

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var appearentTemperatureLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activiryIndicator: UIActivityIndicatorView!
    
    let locationManager = CLLocationManager()
    
    let formatter = MeasurementFormatter()
    
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        toggleActivityIndicator(on: true)
        fetchCurrentWeatherData()
    }
    
    func toggleActivityIndicator(on: Bool) {
        refreshButton.isHidden = on
        if on {
            activiryIndicator.startAnimating()
        } else {
            activiryIndicator.stopAnimating()
        }
    }
    
    lazy var weatherManager = APIWeatherManager(apiKey: "2a6d8e376a69c1ae07d4a52dd0c2dfdc")
    //let coordinates = Coordinates(latitude: 53.917950, longitude: 27.561776)
    let coordinates = Coordinates(latitude: 18, longitude: 9) //nigeria
    //let coordinates = Coordinates(latitude: -11153.917950, longitude: -11127.561776)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        fetchCurrentWeatherData()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last! as CLLocation
        
        print("my locayion latitude: \(userLocation.coordinate.latitude), longitude: \(userLocation.coordinate.longitude)")
    }
    
//    func fetchCurrentWeatherData(){
//        weatherManager.fetchCurrentWeatherWith(coordinates: coordinates) { (result) in
//            self.toggleActivityIndicator(on: false)
//
//            switch result {
//            case .Success(let currentWeather):
//                self.updateUIWith(currentWeather: currentWeather)
//            case .Failure(let error as NSError):
//
//                let alertController = UIAlertController(title: "Unable to get data ", message: "\(error.localizedDescription)", preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                alertController.addAction(okAction)
//
//                self.present(alertController, animated: true, completion: nil)
//            default: break
//            }
//        }
//    }
    
    func fetchCurrentWeatherData(){
        APIManager2.sharedInstance.fetchCurrentWeatherWith(coordinates: coordinates) { [weak self] (currentWeather) in
            self?.updateUIWith(currentWeather: currentWeather)
//            { [weak self] (weatherData) in
//                self?.updateUI(weatherData: weatherData)
//            }
        }
    }
    
    func updateUIWith(currentWeather: CurrentWeather) {
        formatter.locale = Locale.current
        let measurement = Measurement(value: currentWeather.temperature, unit: UnitTemperature.fahrenheit)
        let temperature = formatter.string(from: measurement)

        self.imageView.image = currentWeather.icon
        self.pressureLabel.text = currentWeather.pressureString
        self.temperatureLabel.text = "\(currentWeather.temperatureString) / \(temperature)"
        self.appearentTemperatureLabel.text = currentWeather.appearentTemperatureString
        self.humidityLabel.text = currentWeather.humidityString
        locationLabel.text = currentWeather.timeZone
    }
}












