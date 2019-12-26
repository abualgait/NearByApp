 

import UIKit

class APIConstant: NSObject {

}
//For Dev
var HTTP_BASE_URL = "https://api.foursquare.com/v2/venues"
var CLIENT_ID = "ISK31EGE2PYAFEU3JKVR4W2WLJ1YTZHQHWY3LGDHTTGQLOZR"
var CLIENT_SECRET = "UVJPBUDBPGY13IZ0IGHYLFHALJ2OUT11BCOH2E2LTO3ZIXJ3"
var VERSION = "20140715"
var BASE_URL = "\(HTTP_BASE_URL)"

func SSLog(message: Any?) {
    #if DEBUG
        print("\(message)")
    #endif
}


