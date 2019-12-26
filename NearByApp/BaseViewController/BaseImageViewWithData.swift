//
//  BaseImageViewWithData.swift
//  ShareTv
//
//  Created by Mehul Shah on 6/20/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import Masonry
import SDWebImage

class BaseImageViewWithData: UIImageView {
    
  
    
    var placeholder: UIImage?
    //var comefrom = ImageViewComfrom.user
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
//        self.comefrom = comefrom
//        setPlaceHolder()
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
//                    if self.comefrom == ImageViewComfrom.Category {
//                       
//                    }
//                    else if self.comefrom == ImageViewComfrom.Malls {
//                        self.contentMode = .scaleAspectFill
//                    }
                }, completion: { _ in })
                
                
            }
            
        }
    }
    
//    func setPlaceHolder() {
//        clipsToBounds = true
//        if comefrom == ImageViewComfrom.user {
////            placeholder = #imageLiteral(resourceName: "img_placeholder")
//            placeholder = #imageLiteral(resourceName: "small_user")
//            contentMode = .scaleAspectFill
//        }
//        else if comefrom == ImageViewComfrom.Malls {
//            placeholder = #imageLiteral(resourceName: "mall_placeholder")
//            contentMode = .scaleAspectFill
//        }
//        else if comefrom == ImageViewComfrom.Profile {
//            placeholder = #imageLiteral(resourceName: "profile")
//
//        }
//        else if comefrom == ImageViewComfrom.Directory {
//            placeholder = #imageLiteral(resourceName: "placeholder")
//            contentMode = .center
//
//        }
//        else if comefrom == ImageViewComfrom.Shop {
//            placeholder = #imageLiteral(resourceName: "shop_detail_placeholder")
//            contentMode = .scaleToFill
//
//        }
//        else if comefrom == ImageViewComfrom.Category {
//            placeholder = #imageLiteral(resourceName: "category_placeholder")
//            contentMode = .scaleAspectFit
//
//        }
//        else if comefrom == ImageViewComfrom.Banner {
//            placeholder = #imageLiteral(resourceName: "category_placeholder")
//            contentMode = .scaleToFill
//
//        }
//    }
//
}
