
import Foundation
struct WeatherModel : Codable {
	let location : Location?
	let current : Current?
    let forecast : Forecast?

	enum CodingKeys: String, CodingKey {

		case location = "location"
		case current = "current"
        case forecast = "forecast"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		location = try values.decodeIfPresent(Location.self, forKey: .location)
		current = try values.decodeIfPresent(Current.self, forKey: .current)
        forecast = try values.decodeIfPresent(Forecast.self, forKey: .forecast)
	}

}

struct WeatherViewModel { // data to show
    
    var city: String
    var temp_f: String
    var time: String
    var date: String
    var imgURL:String
    var state:String
    var wind_mph:String
    var humidity:String
    
    var todayImgURL:String
    var todayTempfc:String
    var todayName:String
    
    var tomorrowImgURL:String
    var tomorrowTempfc:String
    var tomorrowName:String
    
    var day3ImgURL:String
    var day3Tempfc:String
    var day3Name:String
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM, yyyy"
        return dateFormatter
    }()
    let xdateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    let dayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }()
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter
    }()
    let monthFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM, yyyy"
        return dateFormatter
    }()
   
    init(weatherModel:WeatherModel) {
        city = weatherModel.location?.name ?? ""
        temp_f = "\(weatherModel.current?.temp_f ?? 0.0)°F"
        
        if let myDate = xdateFormatter.date(from: weatherModel.current?.last_updated ?? ""){
        
        date = "\(dateFormatter.string(from: myDate))"
        }else{
            date = ""
        }
        if let myTime = xdateFormatter.date(from: weatherModel.current?.last_updated ?? ""){
        time = "\(timeFormatter.string(from: myTime))"
        }else{
            time = ""
        }
        
        imgURL = "https:" + (weatherModel.current?.condition?.icon ?? "")
        
        state = "it's a \(weatherModel.current?.condition?.text ?? "")"
        
        wind_mph = "\(weatherModel.current?.wind_mph ?? 0.0)"
        
        humidity = "\(weatherModel.current?.humidity ?? 0)%"
        
        todayImgURL = "https:" + (weatherModel.forecast?.forecastday?[0].day?.condition?.icon ?? "")
        todayTempfc  = "\(weatherModel.forecast?.forecastday?[0].day?.maxtemp_c ?? 0.0)°/\(weatherModel.forecast?.forecastday?[0].day?.maxtemp_f ?? 0.0)°F"
        todayName = "Today"
        
         tomorrowImgURL = "https:" + (weatherModel.forecast?.forecastday?[1].day?.condition?.icon ?? "")
         tomorrowTempfc = "\(weatherModel.forecast?.forecastday?[1].day?.maxtemp_c ?? 0.0)°/\(weatherModel.forecast?.forecastday?[1].day?.maxtemp_f ?? 0.0)°F"
         tomorrowName = "Tomorrow"
        
         day3ImgURL = "https:" + (weatherModel.forecast?.forecastday?[2].day?.condition?.icon ?? "")
         day3Tempfc = "\(weatherModel.forecast?.forecastday?[2].day?.maxtemp_c ?? 0.0)°/\(weatherModel.forecast?.forecastday?[2].day?.maxtemp_f ?? 0.0)°F"
        
        if let xmyDate = xdateFormatter.date(from: weatherModel.forecast?.forecastday?[2].date ?? ""){
        day3Name =  "\(dayFormatter.string(from: xmyDate))"
        }else{
            day3Name = ""
        }
    }
    

}
