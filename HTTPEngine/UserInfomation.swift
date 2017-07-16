//
//  UserInfomation.swift
//  EventApp
//
//  Created by Ittipong on 2/8/17.
//  Copyright © 2017 1.0.0. All rights reserved.
//

import UIKit
import ObjectMapper
import Kugel



class UserInfomation: NSObject {
    
    
    let prefs = UserDefaults.standard
    
    static let shareInstance = UserInfomation()
    
    override init(){
        
        super.init()

    }

    var property:PropertyModel?{
        set{
            if let new = newValue {
                if let json = Mapper<PropertyModel>().toJSONString(new, prettyPrint: true) {
                    prefs.set(json, forKey: "PropertyModel")
                }
            }
        }
        get{
            if let json = prefs.string(forKey: "PropertyModel") {
                let model = Mapper<PropertyModel>().map(JSONString: json)
                return model
            }else{
                return nil
            }
        }
    }
    
    var isLogin:Bool {
        set{
            prefs.set(newValue, forKey: "isLogin")
            
            if newValue == true {
                if self.isNotification == true {
                    var tag = [String:Any]()
                    tag["user"] = UserInfomation.shareInstance.userInfo?.id
                    OneSignal.sendTags(tag as [NSObject : Any])
                }else {
                    OneSignal.deleteTag("user")
                }
            }else {
                OneSignal.deleteTag("user")
            }
        }
        get{
            return prefs.bool(forKey: "isLogin")
        }
    }
    
    
    var tokenM:TokenModel?{
        set{
            if let new = newValue {
                if let json = Mapper<TokenModel>().toJSONString(new, prettyPrint: true) {
                    prefs.set(json, forKey: "TokenModel")
                }
            }
        }
        get{
            if let json = prefs.string(forKey: "TokenModel") {
                let model = Mapper<TokenModel>().map(JSONString: json)
                return model
            }else{
                return nil
            }
        }
    }
    
    
    var userInfo:UserModel? {
        set{
            if let new = newValue {
                if let json = Mapper<UserModel>().toJSONString(new, prettyPrint: true) {
                    prefs.set(json, forKey: "userInfo")
                }
            }
        }
        get{
            if let json = prefs.string(forKey: "userInfo") {
                let model = Mapper<UserModel>().map(JSONString: json)
                return model
            }else{
                return nil
            }
        }
        
        
    }

    
    var userDetail:UserDetailModel? {
        get{
            return userInfo?.usersDetail
        }
    }
    
    var isFristSetNotif:Bool? {
        set {
            if let flag = newValue {
                prefs.set(flag, forKey: "isFristSetNotif")
            }else {
                prefs.set(false, forKey: "isFristSetNotif")
            }
        }
        
        get {
            return prefs.bool(forKey: "isFristSetNotif")
        }
    }
    
    var isNotification:Bool? {
        set{
            if let flag = newValue {
                if flag {
                    var tag = [String:Any]()
                    tag["user"] = UserInfomation.shareInstance.userInfo?.id
                    OneSignal.sendTags(tag as [NSObject : Any])
                }else{
                    OneSignal.deleteTag("user")
                }
                prefs.set(flag, forKey: "isNotification")
            }else {
                prefs.set(false, forKey: "isNotification")
            }
        }
        
        get {
            return prefs.bool(forKey: "isNotification")
        }
    }
    
    var userAvatar:AvatarModel? {
        get{
            return userInfo?.userAvatar
        }
    }

    var country:Country {
        
        set{
            
            prefs.set(newValue.rawValue, forKey: "Country")
            
        }
        get{
            if let lang = prefs.string(forKey: "Country") {
                if lang == "singapore" {
                    prefs.set("singapore", forKey: "Country")
                    
                    return .singapore
                }else {
                    prefs.set("thai", forKey: "Country")
                    return .thai
                }
            }else{
                
                return .thai
            }
        }
    }
    
    
    var language:Language?{
        
        set{
            if let lang = newValue {
                prefs.set(lang.rawValue, forKey: "language")
            }else {
                
            }
        }
        get{

            if let lang = prefs.string(forKey: "language") {
                if lang == "th" {
                    prefs.set("th", forKey: "language")
                    return .th
                }else if lang == "en" {
                    prefs.set("en", forKey: "language")
                    return .en
                }else {
                    prefs.set("jp", forKey: "language")
                    return .jp
                }
            }else{
                prefs.set("en", forKey: "language")
                return .en
            }
        }
    }
    
    var fromNotification:Bool? {
        set{
            prefs.set(false, forKey: "fromNotification")
        }
        
        get {
            return prefs.bool(forKey: "fromNotification")
        }
    }
    
    func localizedStringWithKey(key:String?) -> String?{
        
        var lang : String = ""
        
        switch (language) {
        case .en? :
            lang = "En"
            break
        case .th? :
            lang = "Th"
            break
        case .jp? :
            lang = "En"
            break
        default:
            lang = "Th"
            break
        }
        guard let k = key else {
            return key
        }
        
        let text = NSLocalizedString(k, tableName: lang, bundle: Bundle.main, value: "", comment: "")
        return text
        
        
    }
    
    
}
