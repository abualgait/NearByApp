

import UIKit
import Alamofire
import RxAlamofire
import RxSwift
enum APIPostBodyType : Int {
    case APIPostBodyTypeParameters
    case APIPostBodyTypeJson
    case APIPostBodyTypeRawJson
}
enum APIRestAction : Int {
 
    case getPlaceslist = 1
    case getPhotos = 2
}


class BaseAPI: NSObject {
    var postBodyType = APIPostBodyType.APIPostBodyTypeParameters;
    var pathComponents = NSMutableArray()
    var parameters = NSMutableDictionary()
    
    convenience init(params dict: NSDictionary?) {
        self.init()
        
        for (_, _) in dict! {
            parameters.addEntries(from: dict as! [AnyHashable : Any]);
        }
    }
    
    func RxGETAction(completion: @escaping (Observable<Any>) -> Void)
    {
        let urlString = self.urlString();
        print("RxGET \(urlString)")
        print("RxPARAMETERS \(parameters)")
        let observable = RxAlamofire.json( HTTPMethod.get,
                                           urlString,
                                           parameters: (self.parameters as NSDictionary) as? Parameters,
                                           encoding: URLEncoding.default, headers: nil)
        completion(observable)
      
       
    }
    func GETAction(completion: @escaping (DataResponse<Any>) -> Void)
    {
        let urlString = self.urlString();

        // print("HEADERS \(headers)")
        print("GET \(urlString)")
        print("PARAMETERS \(parameters)")
        
//        try URLEncoding.default.encode(urlRequest, with: parameters)
//                    break
        
        Alamofire.request(urlString, method: HTTPMethod.get, parameters: (self.parameters as NSDictionary) as? Parameters, encoding: URLEncoding.default, headers: nil).validate().responseJSON { (response:DataResponse<Any>) in
            switch (response.result) {
            case .success:
                //do json stuff
                completion(response)
                break
            case .failure(let error):
                if error._code == NSURLErrorTimedOut {
                    //HANDLE TIMEOUT HERE
                    //print(response)
                    //completion(response)

                }
                else{
                    completion(response)
                }
                print("\n\nAuth request failed with error:\n \(error)")
                break
            }
        }
    }

      func POSTAction(completion: @escaping (DataResponse<Any>) -> Void)
      {
        let urlString = self.urlString();

        print("POST \(urlString)")
        print("PARAMETERS \(parameters)")
        
               
        Alamofire.request(urlString, method: HTTPMethod.post, parameters: (self.parameters as NSDictionary) as? Parameters, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response:DataResponse<Any>) in
            switch (response.result) {
            case .success:
                //do json stuff
                completion(response)
                break
            case .failure(let error):
                if error._code == NSURLErrorTimedOut {
                    //HANDLE TIMEOUT HERE
                    
                }
                else{
                    completion(response)
                }
                print("\n\nAuth request failed with error:\n \(error)")
                break
            }
        }
      }
    
    func PUTAction(completion: @escaping (DataResponse<Any>) -> Void)
    {
        let urlString = self.urlString();
        print("PUT \(urlString)")
        print("PARAMETERS \(parameters)")
        // print("HEADERS \(headers)")
        
        Alamofire.request(urlString, method: HTTPMethod.put, parameters: (self.parameters as NSDictionary) as? Parameters, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response:DataResponse<Any>) in
            completion(response)
        }
    }
    
    func DELETEAction(completion: @escaping (DataResponse<Any>) -> Void)
    {
        let urlString = self.urlString();

        // print("HEADERS \(headers)")
        print("DELETE \(urlString)")
        print("PARAMETERS \(parameters)")
        
        Alamofire.request(urlString, method: HTTPMethod.delete, parameters: (self.parameters as NSDictionary) as? Parameters, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response:DataResponse<Any>) in
            completion(response)
        }
    }
    
    func upload (multipartFormDataBlock: @escaping (MultipartFormData) -> Void, encodingCompletion: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?) {
        let urlString = self.urlString();

        print("POST \(urlString)")
        print("PARAMETERS \(parameters)")
        
        Alamofire.upload(multipartFormData: { (multipartFormData1) in
            for (key, value) in self.parameters {
                multipartFormData1.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key as! String)
            }
            multipartFormDataBlock(multipartFormData1)
        }, to: urlString, encodingCompletion: encodingCompletion);
        
    }
    
    
    func urlString() -> String {
        var urlString: String = BASE_URL
        if pathComponents.count > 0 {
            let path: String = "/" + pathComponents.componentsJoined(by: "/")
            urlString += path
        }
       /* if urlParameters.count > 0 {
            let params = CMDQueryStringSerialization.queryString(withDictionary: urlParameters)
            urlString += "?\(params)"
        }*/
        //VVLog(@"%@", urlString);
        return urlString
    }
}
