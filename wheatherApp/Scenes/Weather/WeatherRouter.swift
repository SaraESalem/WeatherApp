
import UIKit

class WeatherRouter: WeatherRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(WeatherViewController.self)") as! WeatherViewController
        let interactor = WeatherInteractor()
        let router = WeatherRouter()
        let presenter = WeatherPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
}
