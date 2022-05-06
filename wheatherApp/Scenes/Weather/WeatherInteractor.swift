
import Foundation

class WeatherInteractor: WeatherInteractorInputProtocol {
    
    weak var presenter: WeatherInteractorOutputProtocol?
   
    func getCurrentWeather(q:String){
        APIClient.CurrentWeather(q:q) { [weak self] (response:Result<WeatherModel>) in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                self.presenter?.weatherFetchedSuccessfully(result: result)
            case .failure(let error):
                self.presenter?.weatherFetchingFailed(withError: error)
            }
        }
    }
    
    func doSearch(key: String){
        APIClient.search(key: key) { [weak self] (response:Result<[Cities]>) in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                self.presenter?.citiesFetchedSuccessfully(cities: result)
            case .failure(let error):
                self.presenter?.citiesFetchingFailed(withError: error)
            }
        }
    }
}
