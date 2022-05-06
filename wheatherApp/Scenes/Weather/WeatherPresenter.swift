
import Foundation
 
class WeatherPresenter: WeatherPresenterProtocol, WeatherInteractorOutputProtocol {
   
    weak var view: WeatherViewProtocol?
    private let interactor: WeatherInteractorInputProtocol
    private let router: WeatherRouterProtocol
    
    private var weatherModel:WeatherModel?
    private var cities:[Cities] = []
    
    var numberOfRows: Int {
        return cities.count
    }
   
    
    init(view: WeatherViewProtocol, interactor: WeatherInteractorInputProtocol, router: WeatherRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func getWeather(q:String) {
        view?.showLoadingIndicator()
        interactor.getCurrentWeather(q:q)
    }
    
    func makeSearching(key: String){
        interactor.doSearch(key: key)
    }
    func citiesFetchedSuccessfully(cities: [Cities]) {
        view?.hideLoadingIndicator()
        self.cities.append(contentsOf: cities)
        view?.reloadData()
    }
    
    func citiesFetchingFailed(withError error: Error) {
        view?.hideLoadingIndicator()
        view?.showErrorMessage(message: error)
    }
    func weatherFetchedSuccessfully(result: WeatherModel) {
        view?.hideLoadingIndicator()
        self.weatherModel = result
        view?.populateWeatherData(weather:WeatherViewModel(weatherModel: result))
    }
    
    func weatherFetchingFailed(withError error: Error) {
        view?.hideLoadingIndicator()
        view?.showErrorMessage(message: error)
    }
    
    func getCity(at index : Int)->Cities{
        return cities[index]
    }
}
