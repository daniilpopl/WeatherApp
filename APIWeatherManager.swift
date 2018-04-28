
import Foundation

struct Coordinates {
  let latitude: Double
  let longitude: Double
}

enum ForecastType: FinalURLPoint {
  case Current(apiKey: String, coordinates: Coordinates)
  
  var baseURL: URL {
    return URL(string: "https://api.forecast.io")!
  }
  
  var path: String {
    switch self {
    case .Current(let apiKey, let coordinates):
      return "/forecast/\(apiKey)/\(coordinates.latitude),\(coordinates.longitude)"
    }
  }
  
  var request: URLRequest {
    let url = URL(string: path, relativeTo: baseURL)
    return URLRequest(url: url!)
  }
}



final class APIWeatherManager: APIManager {
  var sessionConfiguration: URLSessionConfiguration

  lazy var session: URLSession = {
    return URLSession(configuration: self.sessionConfiguration)
  } ()
  
  let apiKey: String
  
  init(sessionConfiguration: URLSessionConfiguration, apiKey: String) {
    self.sessionConfiguration = sessionConfiguration
    self.apiKey = apiKey
  }
  
  convenience init(apiKey: String) {
    self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
  }
  
  func fetchCurrentWeatherWith(coordinates: Coordinates, completionHandler: @escaping (APIResult<WeatherData>) -> Void) {
    let request = ForecastType.Current(apiKey: self.apiKey, coordinates: coordinates).request
    
    fetch(request: request, parse: { (json) -> WeatherData? in
      if let dictionary = json["currently"] as? [String: AnyObject] {
        return WeatherData(JSON: dictionary)
      } else {
        return nil
      }
      
      }, completionHandler: completionHandler)
  }
}












