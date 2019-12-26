 
import UIKit
import Alamofire
import RxSwift

class NearByClientAPI: NSObject {
  
    
    func getPlaceslistAPI(  strLat: String, strLng: String,success: @escaping (_ result: NearByPlacesResponse) -> Void, failure: @escaping (_ error: String?) -> Void) {
        
        let parameters:NSDictionary = [
            "ll" : strLat+","+strLng,
            "radius": "1000",
            "client_id": CLIENT_ID,
            "client_secret" : CLIENT_SECRET,
            "v" : VERSION
        ]
         let api = BaseRestAPI(params: parameters)
        api.GETAction(action: .getPlaceslist) { (response) in
            if(SSError.isErrorReponse(operation: response.response))
            {
                let error = SSError.errorWithData(data:response)
                failure(SSError.getErrorMessage(error))
            }
            else
            {
                let dictResponse : NSDictionary? = response.result.value as? NSDictionary
                let objParsed = NearByPlacesResponse(dictionary: dictResponse!)
                success (objParsed)
            }
        }
    }
    
    func getPhotosAPI(  id: String,success: @escaping (_ result: PhotosResponse) -> Void, failure: @escaping (_ error: String?) -> Void) {
        
        let parameters:NSDictionary = [
            "client_id": CLIENT_ID,
            "client_secret" : CLIENT_SECRET,
            "v" : VERSION
        ]
        let api = BaseRestAPI(params: parameters)
        api.GETAction(action: .getPhotos,id: id) { (response) in
            if(SSError.isErrorReponse(operation: response.response))
            {
                let error = SSError.errorWithData(data:response)
                failure(SSError.getErrorMessage(error))
            }
            else
            {
                let dictResponse : NSDictionary? = response.result.value as? NSDictionary
                let objParsed = PhotosResponse(dictionary: dictResponse!)
                success (objParsed)
            }
        }
    }
    
    
    
}
