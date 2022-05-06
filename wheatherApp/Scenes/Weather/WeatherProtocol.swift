
import Foundation

protocol WeatherViewProtocol: class { // by vc
    var presenter: WeatherPresenterProtocol! { get set }
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func reloadData()
    func populateWeatherData(weather:WeatherViewModel)
    func showErrorMessage(message: Error)
}

protocol WeatherPresenterProtocol: class {
    var view: WeatherViewProtocol? { get set }
    func getWeather(q:String)
    var numberOfRows: Int { get }
    func getCity(at index : Int)->Cities
    func makeSearching(key: String)
}

protocol WeatherRouterProtocol {
    
}

protocol WeatherInteractorInputProtocol {
    var presenter: WeatherInteractorOutputProtocol? { get set }
    func getCurrentWeather(q:String)
    func doSearch(key: String)
}

protocol WeatherInteractorOutputProtocol: class { // implemented by presenter
    func weatherFetchedSuccessfully(result: WeatherModel)
    func weatherFetchingFailed(withError error: Error)
    func citiesFetchedSuccessfully(cities: [Cities])
    func citiesFetchingFailed(withError error: Error)
}
