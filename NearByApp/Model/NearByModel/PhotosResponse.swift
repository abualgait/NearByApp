
import Foundation

class PhotosResponse: EVModelModified {
    var meta = Meta()
    var response = PhotoRes()
    
}

class PhotoRes : EVModelModified{
    var photos = PhotosPOJO()
    
}

class PhotosPOJO: EVModelModified {
   var items: [ItemPOJO]? = []
}


class ItemPOJO: EVModelModified{
   
    var prefix: String = ""
    
    var suffix: String = ""
    
    var width: String = ""
    
    var height: String = ""
}
