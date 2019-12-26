 
import UIKit
import Alamofire
import RxSwift

class NearByClientAPI: NSObject {
 
  
    func RxgetPlaceslistAPI(  strLat: String, strLng: String,success: @escaping (_ result: Observable<Any>) -> Void, failure: @escaping (_ error: String?) -> Void) {
        
        let parameters:NSDictionary = [
            "ll" : strLat+","+strLng,
            "radius": "1000",
            "client_id": "IE3MM3MDDVTY3KEIZZFGY5GLL0XKCMQJQQKBN1ELNZ13S1HE",
            "client_secret" : "J3MVXYWQKQOYWLLJ01EE53Y1OEH0SVPBSAEJMUROBPDVD1DE",
            "v" : "20140715"
        ]
        let api = BaseRestAPI(params: parameters)
        api.RxGETAction(action: .getPlaceslist) { (response) in
            response.subscribe(onNext: { (obj) in
              
                     success (response)
            })
 
        }
    }
    
    
    func getPlaceslistAPI(  strLat: String, strLng: String,success: @escaping (_ result: NearByPlacesResponse) -> Void, failure: @escaping (_ error: String?) -> Void) {
        
        let parameters:NSDictionary = [
            "ll" : strLat+","+strLng,
            "radius": "1000",
            "client_id": "IE3MM3MDDVTY3KEIZZFGY5GLL0XKCMQJQQKBN1ELNZ13S1HE",
            "client_secret" : "J3MVXYWQKQOYWLLJ01EE53Y1OEH0SVPBSAEJMUROBPDVD1DE",
            "v" : "20140715"
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
            "client_id": "IE3MM3MDDVTY3KEIZZFGY5GLL0XKCMQJQQKBN1ELNZ13S1HE",
            "client_secret" : "J3MVXYWQKQOYWLLJ01EE53Y1OEH0SVPBSAEJMUROBPDVD1DE",
            "v" : "20140715"
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
