 
import UIKit

class NearByPlacesResponse: EVModelModified {
    var meta = Meta()
    var response = Response()

}
class Meta : EVModelModified{
var code: Int = 0
var requestId: String? = ""
}

class Response : EVModelModified{
 var venues: [Venue]? = []
 var confident: Bool = false
}

class Venue: EVModelModified {
    var id: String = ""
    var name: String = ""
    var location: VenueLocation?
    var image: String = ""
}


class VenueLocation: EVModelModified{
//i used cc instead of address cause not all objects has key address
    var cc: String = ""
}
