 

import UIKit

class APIConstant: NSObject {

}
//For Dev
var HTTP_BASE_URL = "https://api.foursquare.com/v2/venues"
var BASE_URL = "\(HTTP_BASE_URL)"

func SSLog(message: Any?) {
    #if DEBUG
        print("\(message)")
    #endif
}


