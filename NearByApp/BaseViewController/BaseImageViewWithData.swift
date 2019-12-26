 
import UIKit
import Masonry
import SDWebImage

class BaseImageViewWithData: UIImageView {
    
  
    
    var placeholder: UIImage?
     var activity: UIActivityIndicatorView?
    
    func getImageWithURL(_ stringURL: String?) {
        if activity == nil {
            activity = UIActivityIndicatorView()
            activity?.style = .gray
            addSubview(activity!)
            
            _ = activity?.mas_makeConstraints { (make:MASConstraintMaker?) in
                _ = make?.centerX.equalTo()(self.mas_centerX)
                _ = make?.centerY.equalTo()(self.mas_centerY)
            }
        }
 
        loadImage1(withURL: stringURL)
    }
    
    func loadImage1(withURL stringURL: String?) {
        if stringURL == "" || stringURL == nil {
            image = placeholder
            return
        }
        var url: URL?
        url = URL(string: stringURL!)
        activity?.startAnimating()
        weak var weakSelf: BaseImageViewWithData? = self
        sd_setImage(with: url, placeholderImage: placeholder, options: []) { (_ image, _ error, _ cacheType, _ originalImageURL) in
            self.activity?.stopAnimating()
            if (image != nil) {
                UIView.transition(with: weakSelf!, duration: 0.2, options: .transitionCrossDissolve, animations: {() -> Void in
                    weakSelf?.image = image
                     self.contentMode = .scaleToFill
 
                }, completion: { _ in })
                
                
            }
            
        }
    }
 
}
