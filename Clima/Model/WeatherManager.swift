import Foundation

struct Weathermanager {
    
    // Paste your API key here from https://openweathermap.org
    static let API_KEY = "x"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(API_KEY)&units=metric"
    
    func fetchWeather(cityName: String){
        let url = "\(weatherURL)&q=\(cityName)"
        performRequest(url: url)
    }
    
    func performRequest(url: String) {
        let url = URL(string: url)!
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            if data != nil {
                let dataString = String(data: data!, encoding: .utf8)
                print(dataString)
            }
            parseJSON(weatherData: data!)
        }
        
        task.resume()
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
        } catch {
            
        }
        
    }
}
