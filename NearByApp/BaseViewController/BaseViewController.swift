import UIKit
import Masonry
import Reachability

class BaseViewController: UIViewController {

    var activityLoader: UIActivityIndicatorView?
    var lblLoading: UILabel?
    var utility = Utility()
    var lblNoRecord : UILabel!
    var lblServerError: UILabel!
    var vwOffline: NoInternetView?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initLoaderActivity()
        self.initEmptyDataLabel()
        self.initlblServerErrorLabel()
        self.initOfflineView()
        self.showOfflineView(false, error: "No Connection available")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        

    }
    
    
    func initLoaderActivity(withFrame frame: CGRect) {
        activityLoader = UIActivityIndicatorView(style: .gray)
        activityLoader?.frame = frame
        //activityLoader?.tintColor = UICOLOR_NAVIGATION_BG
        view.addSubview(activityLoader!)
        activityLoader?.isHidden = true
        lblLoading = UILabel(frame: CGRect(x: CGFloat(8), y: CGFloat((activityLoader?.frame.size.height)! + (activityLoader?.frame.origin.y)! + 10), width: CGFloat(SCREEN_SIZE.width - 16), height: CGFloat(17)))

        lblLoading?.translatesAutoresizingMaskIntoConstraints = true
        lblLoading?.textAlignment = .center
        lblLoading?.textColor = UIColor.black
        view.addSubview(lblLoading!)
        lblLoading?.isHidden = true
    }

    func initLoaderActivity() {
        initLoaderActivity(withFrame: CGRect(x: CGFloat((SCREEN_SIZE.width / 2.0) - 10), y: CGFloat((SCREEN_SIZE.height / 2.0) - 50), width: CGFloat(20), height: CGFloat(20)))
     //    activityLoader?.tintColor = UICOLOR_NAVIGATION_BG
    }
 
 
    func startLoadingActivity() {
    activityLoader?.isHidden = false
    lblLoading?.isHidden = false
    activityLoader?.startAnimating()
    }
    
    func stopLoadingActivity() {
        activityLoader?.isHidden = true
        lblLoading?.isHidden = true
        if (activityLoader?.isAnimating)! {
            activityLoader?.stopAnimating()
        }
    }

 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isInternetAvailable() -> Bool
    {
        if let reachability =  try? Reachability() {
            if   reachability.connection == .unavailable {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
  
    // MARK:- EmptyLabel SetUp
    func initEmptyDataLabelWithFrame(frame: CGRect)
    {

        self.lblNoRecord = UILabel(frame: frame)
        self.lblNoRecord.textAlignment = .center
        self.lblNoRecord.numberOfLines = 0

        self.view!.addSubview(self.lblNoRecord)
        self.lblNoRecord.isHidden = true
    }

    func initEmptyDataLabel() {
        self.initEmptyDataLabelWithFrame(frame: CGRect(x: CGFloat(20), y: SCREEN_SIZE.height / 2.0 - 100, width: CGFloat(SCREEN_SIZE.width-40), height: 90))
    }

    func showEmptyDataLabelWithMsg(message: String) {
        self.lblNoRecord.text = message
        self.lblNoRecord.isHidden = false
        self.view.bringSubviewToFront(self.lblNoRecord)
    }
    func hideEmptyDataLabel()
    {
        self.lblNoRecord.isHidden = true

    }
    
    
    // MARK:- Server Error SetUp
    func initServerErrorLabelWithFrame(frame: CGRect)
    {
        
        self.lblServerError  = UILabel(frame: frame)
        self.lblServerError.textAlignment = .center
        self.lblServerError.numberOfLines = 0
        
        self.view!.addSubview(self.lblServerError)
        self.lblServerError.isHidden = true
    }
    
    func initlblServerErrorLabel() {
        self.initServerErrorLabelWithFrame(frame: CGRect(x: CGFloat(20), y: SCREEN_SIZE.height / 2.0 - 100, width: CGFloat(SCREEN_SIZE.width-40), height: 90))
    }
    
    func showlblServerErrorLabelWithMsg(message: String) {
        self.lblServerError.text = message
        self.lblServerError.isHidden = false
        self.view.bringSubviewToFront(self.lblServerError)
    }
    func hideServerErrorLabel()
    {
        self.lblServerError.isHidden = true
        
    }
    func initOfflineView() {
        initOfflineView(withFrame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(SCREEN_SIZE.width), height: CGFloat(SCREEN_SIZE.height - 60)))
    }
    func initOfflineView(withFrame frame: CGRect) {
        vwOffline = UINib(nibName: "NoInternetView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? NoInternetView
        vwOffline?.frame = frame
        view.addSubview(vwOffline!)

        _ =  self.vwOffline?.mas_makeConstraints { (make:MASConstraintMaker?) in
            _ = make?.width.equalTo()(frame.size.width)
            _ = make?.top.equalTo()(frame.origin.y)
            _ = make?.height.equalTo()(frame.size.height-100)
            _ = make?.left.equalTo()(frame.origin.x)
            // _ = make?.right.equalTo()(0)
            //_ = make?.bottom.equalTo()(0)
        }

        // vwOffline?.isHidden = true
    }
    func showOfflineView(_ show: Bool, error: NSString?) {
        if show {
            vwOffline?.showConnectivityMessage(error)
            vwOffline?.isHidden = false
        }
        else {
            vwOffline?.isHidden = true
        }
    }
 

}
