import Alamofire
import UIKit

enum Result<T> {
    case success(T)
    case failure(Error)
}

class APIClient {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(),show_loading_indicator:Bool = true, completion:@escaping (Result<T>)->Void) -> DataRequest {
        
        return AF.request(route).responseData(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    do{
                        print("-------------------------------------------------------")
                        print(String(data: value, encoding: .utf8) ?? "No Data")
                        let DataResponsed = try JSONDecoder().decode(T.self, from: value)
                        completion(.success(DataResponsed))
                    }
                    catch{
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    static func CurrentWeather<T:Decodable>(q:String = "egypt",completion:@escaping (Result<T>)->Void) {
        performRequest(route: APIRouter.CurrentWeather(q:q), completion: completion)
    }
    static func search<T:Decodable>(key: String,completion:@escaping (Result<T>)->Void) {
        performRequest(route: APIRouter.Search(key: key), completion: completion)
    }

}
