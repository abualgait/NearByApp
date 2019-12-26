
//
//  Constants.swift
//  Dental Care
//
//  Created by Anand Mahajan on 22/06/17.
//  Copyright © 2017 anand mahajan. All rights reserved.
//

import UIKit

func SYSTEM_VERSION_EQUAL_TO(v: Any) -> Any {
    return UIDevice.current.systemVersion.compare(v as! String, options: .numeric) == .orderedSame
}
func SYSTEM_VERSION_GREATER_THAN(v: Any) -> Any {
    return UIDevice.current.systemVersion.compare(v as! String, options: .numeric) == .orderedDescending
}
func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v: Any) -> Bool {
    return UIDevice.current.systemVersion.compare(v as! String, options: .numeric) != .orderedAscending
}
func SYSTEM_VERSION_LESS_THAN(v: Any) -> Any {
    return UIDevice.current.systemVersion.compare(v as! String, options: .numeric) == .orderedAscending
}
func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v: Any) -> Any {
    return UIDevice.current.systemVersion.compare(v as! String, options: .numeric) != .orderedDescending
}

/*--------------User Defaults keys-------------*/
enum FSUserDefaultsKey {
    
    enum DeviceToken {
        private static let Prefix = "FSDeviceToken"
        
        static let Data    = GenerateKey(Prefix, key: "Data")
        static let String  = GenerateKey(Prefix, key: "String")
    }
}

/*----------Notifications---------*/
enum FSNotificationKey {
    
    enum Example {
        private static let Prefix = "Example"
        
        static let Key = GenerateKey(Prefix, key: "Key")
    }
}

/*----------Colors----------*/
enum FSColors {
    static let AppColor = UIColor.black
    static let whiteColor = UIColor.white
    
}

/*----------Helpers----------*/
private func GenerateKey (_ prefix: String, key: String) -> String {
    return "__\(prefix)-\(key)__"
}



let UIAppDelegate = UIApplication.shared.delegate as! AppDelegate

var NAVIGATIONBAR_HEIGHT: CGFloat = 64.0
var TABBAR_HEIGHT: CGFloat = 49.0

let APP_NAME = "Near By"


let SCREEN_SIZE = UIScreen.main.bounds




