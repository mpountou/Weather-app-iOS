import Foundation

struct WeatherManager {
    
    var weatherDelegate: WeatherDelegate? = nil
    
    // Paste your API key here from https://openweathermap.org
    static let API_KEY = "x"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(API_KEY)&units=metric"
    
    func fetchWeather(cityName: String){
        let url = "\(weatherURL)&q=\(cityName)"
        performRequest(url: url)
    }
    func fetchWeather(latitude: Double, longitude: Double){
        let url = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(url: url)
    }
    
    func performRequest(url: String) {
        let url = URL(string: url)!
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                weatherDelegate?.didFailWithError(error: error!)
                return
            }
            
            if data != nil {
                let weatherModel = parseJSON(weatherData: data!)
                if weatherModel != nil {
                    weatherDelegate?.didUpdateWeather(self ,weather: weatherModel!)
                }
            }
            
        }
        
        task.resume()
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temperature = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temperature)
            return weather
        } catch {
            weatherDelegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
}
