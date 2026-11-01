struct WeatherData : Decodable {
    let name: String
    let main: Main
    let weather: [WeatherItem]
}

struct Main: Decodable {
    let temp: Double
}
struct WeatherItem : Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
