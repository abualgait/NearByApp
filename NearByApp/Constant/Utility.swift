 

import UIKit
//import Reachability
import AVFoundation
//import JVFloatLabeledTextField

class Utility: NSObject {
   /* class func isEmpty(_ val: String) -> Bool {
        if val.isEmpty {
            return false
        }
        else
        if  (val == "(null)") == false && (val == "<null>") == false && (val == "") == false && val.isEqual(NSNull()) == false {
            return false
        }
        else {
            return true
        }
    } */
    
    func getUIColor(hex: String, alpha: Double = 1.0) -> UIColor? {
        var cleanString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cleanString.hasPrefix("#")) {
            cleanString.remove(at: cleanString.startIndex)
        }
        
        if ((cleanString.count) != 6) {
            return nil
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cleanString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
//    class func setTextFieldSetting(txtfield: JVFloatLabeledTextField) {
//        txtfield.font = FONT_POPPINS_REGULAR_H14
//        txtfield.textColor = UIColor.white
//        txtfield.floatingLabelTextColor = UICOLOR_LIGHTGRAY
//        txtfield.floatingLabelActiveTextColor = UICOLOR_LIGHTGRAY
//        txtfield.floatingLabelFont = FONT_POPPINS_REGULAR_H12
//        txtfield.floatingLabelYPadding = 1.0
//    }
//
   class func isEmpty(_ str: String) -> Bool {
        let probablyEmpty: String = str.trimmingCharacters(in: CharacterSet.whitespaces)
        if (probablyEmpty.count ) == 0 {
            return true
        }
        return false
    }
    
//    class func isInternetAvailable() -> Bool
//    {
//        if let reachability = Reachability() {
//            if reachability.connection == .none {
//                return false
//            } else {
//                return true
//            }
//        } else {
//            return false
//        }
//    }
    
    class func isSystemGreaterThaniOS8() -> Bool {
        if SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v: "8.0") {
            return true
        }
        else {
            return false
        }
    }
    
//    class func isRequestAccessForCamera() -> Bool {
//        var allow: Bool = false
//        let authStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
//        if authStatus == .authorized {
//            allow = true
//            // NSLog("AVAuthorizationStatusAuthorized access to %@", AVMediaTypeVideo)
//        }
//        else if authStatus == .denied {
//            // denied
//            //NSLog("AVAuthorizationStatusDenied access to %@", AVMediaTypeVideo)
//        }
//        else if authStatus == .restricted {
//            // restricted, normally won't happen
//            //NSLog("AVAuthorizationStatusRestricted access to %@", AVMediaTypeVideo)
//        }
//        else if authStatus == .notDetermined {
//            // not determined?!
//            //SSLog("AVAuthorizationStatusNotDetermined access to %@", AVMediaTypeVideo)
//        }
//
//        return allow
//    }
//
//    class func isEmailValid(_ emailId: String) -> Bool {
//        let emailRegex: String = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}" +
//            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
//            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
//            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
//            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
//            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
//        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
//        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
//        let res: Bool = emailTest.evaluate(with: emailId)
//        return res
//    }
//
//    class func convertToDictionary(text: String) -> [String: Any]? {
//        if let data = text.data(using: .utf8) {
//            do {
//                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        return nil
//    }
//
////    class func dateToString(strDate : NSDate, strFotmat:NSString) -> String{
////
////        let dateFormatter = DateFormatter()
////        dateFormatter.dateFormat = strFotmat as String!
////
////        var str = dateFormatter.string(from: strDate as Date) as Optional
////
////        if let value = str{
////        //in value you will get non optional value
////            str = ("\(value)" as NSString) as String
////        }
////        return str!
////    }
//    
//    class func getTajUserObject()-> TajUser{
//        var objTajUser = TajUser()
//        if let data = UserDefaults.standard.object(forKey: KEY_USER_DATA) {
//            objTajUser = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! TajUser
//        } else {
//            print("object is nil")
//        }
//        return objTajUser
//    }
//
//
//    class func setCornerRadiusForView(viewCorner:UIView, cornerSize:CGFloat){
//        viewCorner.layer.cornerRadius = cornerSize
//        viewCorner.layer.masksToBounds = true
//    }
//
//    class func setPaddingForTextField(txtPadding:UITextField){
//        let paddingView = UIView()
//        paddingView.frame = CGRect(x: 0, y: 0, width: 5, height: txtPadding.frame.height)
//        txtPadding.leftView = paddingView
//        txtPadding.leftViewMode = UITextFieldViewMode.always
//    }
//
//    // MARK:- getProfileBirthdateDate method
//    class func getProfileBirthdateDate(strDate:NSString) -> String{
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = NSLocale.current
//        dateFormatter.dateFormat = kDateFormatTypeWithoutT
//
//        let yourDate: Date? = dateFormatter.date(from: strDate as String)
//        if(LanguageManager.isParsianLanguage()){
//            dateFormatter.calendar = NSCalendar(identifier: NSCalendar.Identifier.persian)! as Calendar!
//        }
//        var updatedString = ""
//        if(yourDate == nil){
//            updatedString = "-"
//        }
//        else{
//            dateFormatter.dateFormat = kDateFormatTypeProfileBirthdate
//            updatedString = dateFormatter.string(from: yourDate!)
//        }
//        return updatedString
//    }
//
//    class func commentdateToString(strDate : NSDate, strFotmat:NSString) -> String{
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone! // UTC conversion
//        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
//        dateFormatter.dateFormat = strFotmat as String!
//
//        var str = dateFormatter.string(from: strDate as Date) as Optional
//
//        if let value = str{
//            //in value you will get non optional value
//            str = ("\(value)" as NSString) as String
//        }
//        return str!
//    }
//
//
//    // MARK:- getCreatePostDate method
//    class func getCreatePostDate(strDate:NSString) -> NSDate{
//        let dateFormatter = DateFormatter()
////        dateFormatter.locale = NSLocale.current
//        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone! // UTC conversion
//        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
//        dateFormatter.dateFormat = kDateFormatTypeGeneric24Hours
//
//        let yourDate: Date? = dateFormatter.date(from: strDate as String)
////         var updatedString = ""
////        if(yourDate == nil){
////            updatedString = SSLocalizedString("present", "")
////        }
////        else{
////            dateFormatter.dateFormat = kDateFormatTypeWorkExperience
////            updatedString = dateFormatter.string(from: yourDate!)
////        }
//        return yourDate! as NSDate
//    }
//
//
//    class func getTimeStamp() -> String {
//        return "\(Date().timeIntervalSince1970 * 1000)"
//    }
//
//    class func imageIsNullOrNot(imageName : UIImage)-> Bool
//    {
//
//        let size = CGSize(width: 0, height: 0)
//        if (imageName.size.width == size.width)
//        {
//            return false
//        }
//        else
//        {
//            return true
//        }
//    }
//
//
//    class func getPetDate(strDate:NSString) -> String{
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = NSLocale.current
//        dateFormatter.dateFormat = kDateFormatTypeWithoutT
//
//        let yourDate: Date? = dateFormatter.date(from: strDate as String)
//
//        var updatedString = ""
//        if(yourDate == nil){
//            updatedString = "-"
//        }
//        else{
//            dateFormatter.dateFormat = kDateFormatTypeEvent
//            updatedString = dateFormatter.string(from: yourDate!)
//        }
//        return updatedString
//    }
//
//    class func getNotificationDate(strDate:NSString) -> String{
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = NSLocale.current
//        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone! // UTC conversion
//        dateFormatter.dateFormat = kDateFormatTypeGeneric24Hours
//
//        let yourDate: Date? = dateFormatter.date(from: strDate as String)
//
//        var updatedString = ""
//        if(yourDate == nil){
//            updatedString = "-"
//        }
//        else{
//            dateFormatter.dateFormat = kDateFormatTypeEvent
//            updatedString = dateFormatter.string(from: yourDate!)
//        }
//        return updatedString
//    }
//
//    class func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
//        let calendar = NSCalendar.current
//        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
//        let now = NSDate()
//        let earliest = now.earlierDate(date as Date)
//        let latest = (earliest == now as Date) ? date : now
//        let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
//
//        if (components.year! >= 2) {
//            return "\(components.year!) years ago"
//        } else if (components.year! >= 1){
//            if (numericDates){
//                return "1 year ago"
//            } else {
//                return "Last year"
//            }
//        } else if (components.month! >= 2) {
//            return "\(components.month!) months ago"
//        } else if (components.month! >= 1){
//            if (numericDates){
//                return "1 month ago"
//            } else {
//                return "Last month"
//            }
//        } else if (components.weekOfYear! >= 2) {
//            return "\(components.weekOfYear!) weeks ago"
//        } else if (components.weekOfYear! >= 1){
//            if (numericDates){
//                return "1 week ago"
//            } else {
//                return "Last week"
//            }
//        } else if (components.day! >= 2) {
//            return "\(components.day!) days ago"
//        } else if (components.day! >= 1){
//            if (numericDates){
//                return "1 day ago"
//            } else {
//                return "Yesterday"
//            }
//        } else if (components.hour! >= 2) {
//            return "\(components.hour!) hours ago"
//        } else if (components.hour! >= 1){
//            if (numericDates){
//                return "1 hour ago"
//            } else {
//                return "An hour ago"
//            }
//        } else if (components.minute! >= 2) {
//            return "\(components.minute!) minutes ago"
//        } else if (components.minute! >= 1){
//            if (numericDates){
//                return "1 minute ago"
//            } else {
//                return "A minute ago"
//            }
//        } else if (components.second! >= 3) {
//            return "\(components.second!) seconds ago"
//        } else {
//            return "Just now"
//        }
//
//    }
    
//
//   class func getThumbnailFrom(path: URL) -> UIImage? {
//
//        do {
//
//            let asset = AVURLAsset(url: path , options: nil)
//            let imgGenerator = AVAssetImageGenerator(asset: asset)
//            imgGenerator.appliesPreferredTrackTransform = true
//            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
//            let thumbnail = UIImage(cgImage: cgImage)
//
//            return thumbnail
//
//
//
//        } catch let error {
//
//            print("*** Error generating thumbnail: \(error.localizedDescription)")
//            return nil
//
//        }
//
//    }
    
}
