import UIKit
import Alamofire

enum APIRouter: URLRequestConvertible{
    
    case CurrentWeather(q: String)
    case Search(key: String)
    
    
    //MARK:- HTTPMETHOD
    private var method : HTTPMethod{
        switch self {
        
        case .Search:
            return .post
            
        case .CurrentWeather:
            return .get
     
        }
    }
    //MARK:- PATH
    private var path:String{
        switch self {
        //MARK:- SESSION
        case .CurrentWeather(let q):
            return "forecast.json?key=\(Constants.APIKEY)&q=\(q)&days=3"
        case .Search(let key):
            return "search.json?key=\(Constants.APIKEY)&q=\(key)"
        }
    }
    //MARK:- ENCODING
    internal var encoding : ParameterEncoding{
        switch method {
        case .post,.put:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    internal var Auth : Bool{
        switch self {
        case .CurrentWeather,.Search:
            return true
        default:
            return false
        }
    }
    
    private var parameters:[String:Any]?{
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
      
        let url = try Constants.baseURL.asURL().appendingPathComponent(path).absoluteString.removingPercentEncoding?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var urlRequest = URLRequest(url: try url!.asURL())
        //HTTP METHOD
        urlRequest.httpMethod = method.rawValue
        
        //PARAMETERS
        if let parameters = parameters{
            do{
                print("Parameters \(parameters)")
                
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch{
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return try! encoding.encode(urlRequest, with: parameters)
    }
}
