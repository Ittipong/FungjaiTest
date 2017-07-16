//
//  Router.swift
//  HTTPEngine 2.0
//
//  Created by Ittipong on 1/13/16.
//  Copyright © 2016 Pheonec. All rights reserved.
//

import UIKit
import Alamofire

extension String: ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}
struct RAW {
    
    var data:Data?
    
    init(parameters:[String:Any]){
        
        do {
            data = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        } catch {
            // No-op
            print("JSON SYNTAX ERROR ##############")
        }
    }
}




enum Router: URLRequestConvertible {
    
    
    static var token: String? {
        get{
            guard let tokenModel = UserInfomation.shareInstance.tokenM else {
                return nil
            }
            
            //For Log In Facebook
            if tokenModel.fbToken?.accessToken != nil {
                let tokenType = "Bearer"
                print("FBToken : "+"\(tokenType) \(tokenModel.accessToken.stringValue)")
                return "\(tokenType) \(tokenModel.accessToken.stringValue)"
            }else {
                print("Token : "+"\(tokenModel.tokenType.stringValue) \(tokenModel.accessToken.stringValue)")
                return "\(tokenModel.tokenType.stringValue) \(tokenModel.accessToken.stringValue)"
            }
        }
    }
    
    
    case Request(Requestor)
    var request: Requestor {
        
        switch self {
            
        case .Request(let req):
            return req
        }

    }
    
    // MARK: URLRequestConvertible
    public func asURLRequest() throws -> URLRequest {
        
        if self.request.isRawData == true {
            //-- สำหรับหน้า Search Property -----
            if self.request.isNotBearer {
                /*
                var mutableURLRequest = request.path
                mutableURLRequest?.setValue("application/json",forHTTPHeaderField: "Accept")
                
                if let tokenModel = UserInfomation.shareInstance.tokenM {
                    let data = request.data
                    mutableURLRequest?.setValue(tokenModel.accessToken.stringValue,forHTTPHeaderField: "Authorization")
                    return try JSONEncoding.default.encode(mutableURLRequest!, with:data)
                }else {
                    let data = request.data
                    mutableURLRequest?.setValue(Router.token.stringValue,forHTTPHeaderField: "Authorization")
                    return try JSONEncoding.default.encode(mutableURLRequest!, with:data)
                }
                 */
                
                /*
                var mutableURLRequest = request.path
                mutableURLRequest?.setValue("application/json",forHTTPHeaderField: "Content-Type")
                
                return try URLEncoding.default.encode(mutableURLRequest!, with: request.data)
                 */
                
                var mutableURLRequest = request.path
                
                if let tokenModel = UserInfomation.shareInstance.tokenM {
                    print("HTTPHeaderField : isRaw Authorization NoBearer")
                    
                    mutableURLRequest?.setValue("application/json",forHTTPHeaderField: "Accept")
                    
                    let data = request.data
                    mutableURLRequest?.setValue(tokenModel.accessToken.stringValue,forHTTPHeaderField: "Authorization")
                    
                    return try JSONEncoding.default.encode(mutableURLRequest!, with:data)
                }
//                else if let tokenFB = UserInfomation.shareInstance.tokenM {
//                    print("HTTPHeaderField : isRaw Authorization NoBearer Facebook")
//                    var mutableURLRequest = request.path
//                    mutableURLRequest?.setValue("application/json",forHTTPHeaderField: "Accept")
//                    
//                    return try URLEncoding.default.encode(mutableURLRequest!, with: request.data)
//                }
                else {
                    print("HTTPHeaderField : isRaw Content-Type")
                    
                    //mutableURLRequest?.setValue("application/json",forHTTPHeaderField: "Content-Type")
                    mutableURLRequest?.setValue("application/json",forHTTPHeaderField: "Accept")
                    
                    return try URLEncoding.default.encode(mutableURLRequest!, with: request.data)
                }
            }
            /*
            else if self.request.isToken == false {
                // User Facebook
                var mutableURLRequest = request.path
                mutableURLRequest?.setValue("application/json",forHTTPHeaderField: "Content-Type")
                
                return try URLEncoding.default.encode(mutableURLRequest!, with: request.data)
            }*/
            else {
                print("HTTPHeaderField : isRaw Authorization Bearer")
                // User Rigister
                var mutableURLRequest = request.path
                mutableURLRequest?.setValue("application/json",forHTTPHeaderField: "Accept")
                
                let data = request.data
                mutableURLRequest?.setValue(Router.token.stringValue,forHTTPHeaderField: "Authorization")
                
                return try JSONEncoding.default.encode(mutableURLRequest!, with:data)
            }
        }else if self.request.isToken == true {
            print("HTTPHeaderField : isToken Authorization Bearer")
            var mutableURLRequest = request.path
            mutableURLRequest?.setValue("application/json",forHTTPHeaderField: "Accept")
            
            let data = request.data
            mutableURLRequest?.setValue(Router.token.stringValue,forHTTPHeaderField: "Authorization")
            
            return try URLEncoding.default.encode(mutableURLRequest!, with: data)
        }else {
            print("HTTPHeaderField : Else Authorization Bearer")
            var mutableURLRequest = request.path
            mutableURLRequest?.setValue("application/json",forHTTPHeaderField: "Accept")
            
            return try URLEncoding.default.encode(mutableURLRequest!, with: request.data)
        }
        
    }
    
    func JSONStringify(json: AnyObject?,prettyPrinted:Bool = false) -> String{
        
        guard let value = json else {
            return "[ ]"
        }
        
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        
        
        if JSONSerialization.isValidJSONObject(value) {
            
            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: options)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }catch {
                
                print("error json formatt")
                //Access error here
            }
            
        }
        return ""
        
    }
}
