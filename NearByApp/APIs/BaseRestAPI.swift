
import UIKit
import Alamofire
import RxSwift
class BaseRestAPI: BaseAPI {
    
    func POSTAction(action : APIRestAction, completion: @escaping (DataResponse<Any>) -> Void) {
        self.setupPathComponents(action)
        super.POSTAction(completion: completion)
    }
    
    func POSTAction(action : APIRestAction, multipartFormData: @escaping (MultipartFormData) -> Void, encodingCompletion: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?) {
        self.setupPathComponents(action)
        super.upload(multipartFormDataBlock: multipartFormData, encodingCompletion: encodingCompletion);
    }
    
    func GETAction(action : APIRestAction,id:String = "", completion: @escaping (DataResponse<Any>) -> Void) {
        self.setupPathComponents(action,id: id)
        super.GETAction(completion: completion)
    }
    
   
    
    
    func setupPathComponents(_ action: APIRestAction,id:String = "") {
        var subPath: NSArray?
       
         if action == .getPlaceslist{
            subPath = ["search"]
        }
        if action == .getPhotos{
            subPath = [id + "/photos"]
        }
        
        if (subPath?.count)! > 0 {
            pathComponents.addObjects(from: subPath as! [Any])
        }
    }
    
    
}
