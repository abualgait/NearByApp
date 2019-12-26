

import Foundation
import UIKit
import Masonry
import SwiftLocation
import CoreLocation

enum MODE : String {
    case SINGLEUPDATE
    case REALTIME
}
class HomeViewController : BaseViewController,UITableViewDelegate,UITableViewDataSource ,SimpleItemClickDelegate,CLLocationManagerDelegate{
    func ItemOnClick(any: AnyObject) {
        
    }
    var manager : CLLocationManager!
    var delegate:SimpleItemClickDelegate?
    @IBOutlet weak var tableView: UITableView!
    var results = NearByPlacesResponse()
    var strLatitude = ""
    var strLongitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Near By"
        setAppearance()
        tableView.register(UINib(nibName: "VenueCell", bundle: nil), forCellReuseIdentifier: "VenueCell")
        tableView.dataSource=self
        tableView.delegate=self
        loadInitialSettings()
        
        //self.rxGetVenues(lat: 30.332331,lng: -122.031219)
        self.getVenues(lat: 37.332331,lng: -122.031219)
    }
    func setAppearance(){
        
    
        if(VVBaseUserDefaults.getStringForKey(kOperationalBehaviour) == MODE.REALTIME.rawValue){
            let item = UIBarButtonItem(title: "Single Update", style: .plain, target: self, action: #selector(changeMode))
           navigationItem.rightBarButtonItem = item
           
          
        }else{
            let item = UIBarButtonItem(title: "Real Time", style: .plain, target: self, action: #selector(changeMode))
             navigationItem.rightBarButtonItem = item
        
        }
        
    }
    
    @objc func changeMode(){
        if(VVBaseUserDefaults.getStringForKey(kOperationalBehaviour)==MODE.REALTIME.rawValue){
            VVBaseUserDefaults.setString(MODE.SINGLEUPDATE.rawValue, forKey: kOperationalBehaviour)
            setAppearance()
        }else{
            VVBaseUserDefaults.setString(MODE.REALTIME.rawValue, forKey: kOperationalBehaviour)
            setAppearance()
        }
    }
    // MARK: -  loadInitialSettings method
    func loadInitialSettings(){
        
        self.initLoaderActivity()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()

        LocationManager.shared.locateFromGPS(.continous, accuracy: .city) { result in
            switch result {
            case .failure(let error):
                debugPrint("Received error: \(error)")
            case .success(let location):
                if(VVBaseUserDefaults.getStringForKey(kOperationalBehaviour)==MODE.REALTIME.rawValue){
                    self.getVenues(lat: location.coordinate.latitude,lng: location.coordinate.longitude)
                    
                }
                
            }
        }
        
        
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var locValue : CLLocationCoordinate2D
        locValue = manager.location!.coordinate
        if(VVBaseUserDefaults.getStringForKey(kOperationalBehaviour) == MODE.REALTIME.rawValue){
           
            self.getVenues(lat: locValue.latitude, lng: locValue.longitude)
        }
    
        manager.stopUpdatingLocation()
    }
    
    
    func rxGetVenues(lat:Double,lng:Double){
        strLatitude = String(format : "%f",lat)
        strLongitude = String(format : "%f",lng)
        if try! self.isInternetAvailable() == true {
            self.startLoadingActivity()
            self.showOfflineView(false, error: "")
            
            NearByClientAPI().RxgetPlaceslistAPI(strLat: strLatitude, strLng: strLongitude, success: { (data) in
               data.subscribe(onNext: {(dic) in
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                    // here "jsonData" is the dictionary encoded in JSON data
                    
                    let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    // here "decoded" is of type `Any`, decoded from JSON data
                    
                    // you can now cast it with the right type
                    if let dictFromJSON = decoded as? NearByPlacesResponse {
                        // use dictFromJSON
                        self.results = dictFromJSON
                        print("Rx" + self.results.meta.requestId!)
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
                
            
                if (self.results.response.venues?.count)! > 0 {
                    self.stopLoadingActivity()
                    self.tableView.reloadData()
                }
                
               }, onError:{(Error) in
             
               }, onCompleted: {
                
               }, onDisposed: {
                
               })
                
            }, failure: { (error) in
                self.stopLoadingActivity()
            })
            
            
        }else{
            self.showOfflineView(true, error:  "No internet connection")
            self.tableView.isHidden = true
            self.vwOffline?.btnRetry?.addTarget(self, action: #selector(self.clickRetry), for: .touchUpInside)
        }
        
        
    }
    
    func getVenues(lat:Double,lng:Double){
          strLatitude = String(format : "%f",lat)
          strLongitude = String(format : "%f",lng)
       if self.isInternetAvailable() == true {
            self.startLoadingActivity()
            self.showOfflineView(false, error: "")
            NearByClientAPI().getPlaceslistAPI( strLat: strLatitude, strLng: strLongitude, success: { (response) in
                self.results = NearByPlacesResponse()
                self.results = response
                
                if (self.results.response.venues?.count)! > 0 {
                    self.stopLoadingActivity()
                    self.tableView.reloadData()
                }
                
            }, failure: { (error) in
                   self.stopLoadingActivity()
            })
        }else{
            self.showOfflineView(true, error:  "No internet connection")
            self.tableView.isHidden = true
            self.vwOffline?.btnRetry?.addTarget(self, action: #selector(self.clickRetry), for: .touchUpInside)
        }

        
    }
    // MARK:- clickRetry method
    @objc func clickRetry(_ sender: Any)
    {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.results.response.venues?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        
    {
        var cell: VenueCell? = tableView.dequeueReusableCell(withIdentifier: "VenueCell") as! VenueCell?
        if cell == nil {
            let topLevelObjects: [Any] = Bundle.main.loadNibNamed("VenueCell", owner: self, options: nil)!
            cell = (topLevelObjects[0] as? VenueCell)
        }
        cell?.configureVenueCell(venue: (self.results.response.venues?[indexPath.row])!)
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell!
    }
   
    
 
    
}
