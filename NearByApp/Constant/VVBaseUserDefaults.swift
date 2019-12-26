
import UIKit

 let kOperationalBehaviour: String = "kOperationalBehaviour"

class VVBaseUserDefaults: NSObject {
    
    class func setString(_ value: String, forKey key: String) {
        self.setStringForKey(key, value: value)
    }
    
    class func setInt(_ value: Int, forKey key: String) {
        self.setIntForKey(key, value: value)
    }
    
    class func setDict(_ value: [AnyHashable: Any], forKey key: String) {
        self.setDictForKey(key, value: value)
    }
    
    class func setArray(_ value: [Any], forKey key: String) {
        self.setArrayForKey(key, value: value)
    }
    
    class func setBool(_ value: Bool, forKey key: String) {
        self.setBoolForKey(key, value: value)
    }
 
    class func getStringForKey(_ key: String) -> String {
        var val: String = ""
        let standardUserDefaults = UserDefaults.standard
        val = standardUserDefaults.string(forKey: key) ?? ""
        return val
    }
    
    class func getIntForKey(_ key: String) -> Int {
        var val: Int = 0
        let standardUserDefaults = UserDefaults.standard
        val = standardUserDefaults.integer(forKey: key)
        return val
    }
    
    class func getFloatForKey(_ key: String) -> CGFloat {
        var val: CGFloat = 0.0
        let standardUserDefaults = UserDefaults.standard
        val = CGFloat(standardUserDefaults.float(forKey: key))
        return val
    }
    
    class func getDictForKey(_ key: String) -> [AnyHashable: Any] {
        var val: [AnyHashable: Any]? = nil
        let standardUserDefaults = UserDefaults.standard
            val = standardUserDefaults.dictionary(forKey: key)
        return val!
    }
    
    class func getArrayForKey(_ key: String) -> [Any] {
        var val: [Any]? = nil
        let standardUserDefaults = UserDefaults.standard
            val = standardUserDefaults.array(forKey: key)
        return val!
    }
    
    class func getBoolForKey(_ key: String) -> Bool {
        var val: Bool = false
        let standardUserDefaults = UserDefaults.standard
            val = standardUserDefaults.bool(forKey: key)
        return val
    }
    
    class func getObjectForKey(_ key: String) -> Any {
        var val: Any?
        let standardUserDefaults = UserDefaults.standard
            val = standardUserDefaults.object(forKey: key)
        return val!
    }
 

    // MARK: - Set values
    class func setStringForKey(_ key: String, value: String) {
        self.setObjectForKey(key, value: value)
    }
    
    class func setIntForKey(_ key: String, value: Int) {
        let standardUserDefaults = UserDefaults.standard
            standardUserDefaults.set(value, forKey: key)
            standardUserDefaults.synchronize()
    }
    
    class func setFloatForKey(_ key: String, value: CGFloat) {
        let standardUserDefaults = UserDefaults.standard
            standardUserDefaults.set(value, forKey: key)
            standardUserDefaults.synchronize()
    }
    
    class func setDictForKey(_ key: String, value: [AnyHashable: Any]) {
        self.setObjectForKey(key, value: value)
    }
    
    class func setArrayForKey(_ key: String, value: [Any]) {
        self.setObjectForKey(key, value: value)
    }

    class func setObjectForKey(_ key: String, value: Any) {
        let standardUserDefaults = UserDefaults.standard
            standardUserDefaults.set(value, forKey: key)
            standardUserDefaults.synchronize()
    }
    
    class func setBoolForKey(_ key: String, value: Bool) {
        let standardUserDefaults = UserDefaults.standard
            standardUserDefaults.set(value, forKey: key)
            standardUserDefaults.synchronize()
    }
    
    class func saveCustomObject(object: AnyObject, key: String) {
        let encodedObject: NSData = NSKeyedArchiver.archivedData(withRootObject: object) as NSData
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(encodedObject, forKey: key)
        defaults.synchronize()
    }
    
    class func removeObjectForKey (key: String) {
        let standardUserDefaults = UserDefaults.standard
        standardUserDefaults.removeObject(forKey: key)
    }
 
    
    class func getPetUserObject(key: String) -> Any {
        let defaults: UserDefaults? = UserDefaults.standard
        let encodedObject = defaults?.object(forKey: key) as? Data
        let object = NSKeyedUnarchiver.unarchiveObject(with: encodedObject!)
        return object ?? ""
    }
    
 
    
}
