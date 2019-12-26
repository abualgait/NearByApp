

import UIKit

class NoInternetView: UIView {
    @IBOutlet var btnRetry: UIButton?
    @IBOutlet var lblMessage: UILabel?
    @IBOutlet var imgNoInternet: UIImageView?

    
    override func awakeFromNib() {
        //self.lblMessage?.font = FONT_POPPINS_REGULAR_H12
        self.lblMessage?.textColor = UICOLOR_SEPERATOR
      //  self.btnRetry?.titleLabel?.font = FONT_POPPINS_REGULAR_H12
       // self.btnRetry?.backgroundColor = UICOLOR_BTN_NOINTERNET
        self.btnRetry?.setTitleColor(UIColor.white, for: .normal)
        self.btnRetry?.layer.cornerRadius = 4.0
        self.btnRetry?.layer.masksToBounds = true
        self.btnRetry?.setTitle("try_again", for: .normal)
    }
    
    func showConnectivityMessage(_ error: NSString?) {
        self.lblMessage?.text = error as String?;
        //self.backgroundColor = UIColor.red;
        self.layoutIfNeeded()
    }
    
    func drawSubviewsWithType() {
       
       // backgroundColor = UICOLOR_GLOBAL_BG
    }

 }
