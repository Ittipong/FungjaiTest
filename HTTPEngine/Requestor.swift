//
//  Service.swift
//  iCash
//
//  Created by Ittipong on 7/24/16.
//  Copyright © 2016 SiamSoftwareSolution. All rights reserved.
//


import Alamofire

class Requestor : NSObject{
    
    var isToken = true
    var isRawData = false
    var isNotBearer = false
    
    var pageIndex = 0
    var pageSize = 10
    
    var urlString:String {
        get{
            guard let url =  path.url?.absoluteString else {
                return HostURL
            }
            return url
        }
    }
    var path:URLRequest!
    var data:[String: Any]?
    
    var raw:Data?
    var method:HTTPMethod = .get
    
    
    init(pathUrl:Path,method:HTTPMethod) {
        
        super.init()
        
        
        guard let urlString = (pathUrl.rawValue).addingPercentEncoding( withAllowedCharacters: .urlPathAllowed) else{
            
            return
        }
        
        guard let URL = URL(string:HostURL+urlString) else {
            
            return
        }
        
        path = URLRequest(url:URL)
        path.httpMethod = method.rawValue
        
        self.method = method
        
        
    }
    
    init(pathUrl:Path,method:HTTPMethod,id:String) {
        
        super.init()
        
        guard let urlString = (pathUrl.rawValue).addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) else{
            
            return
        }
        
        guard let URL = URL(string:HostURL+urlString+id) else {
            return
        }
        
        path = URLRequest(url:URL)
        path.httpMethod = method.rawValue
        
        self.method = method
        
        
    }
    
    init(fullPath:String,method:HTTPMethod,id:String) {
        
        super.init()
        
        
        guard let urlString = fullPath.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) else{
            
            return
        }
        
        guard let URL = URL(string:urlString+id) else {
            return
        }
        
        path = URLRequest(url:URL)
        path.httpMethod = method.rawValue
        
        self.method = method
        
        
    }
    
    init(fullPath:String,method:HTTPMethod) {
        
        super.init()
        
        
        guard let urlString = fullPath.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) else{
            return
        }
        
        guard let URL = URL(string:urlString) else {
            
            return
        }
        
        path = URLRequest(url:URL)
        path.httpMethod = method.rawValue
        
        self.method = method
        
        
    }
    
    init(my2c2pPathUrl:String,method:HTTPMethod) {
        
        super.init()
        
        //let url = "https://demo2.2c2p.com/easyBills/UAT/easybills_middleware_external/JSONexchange.aspx"
        let url = "https://www.easybills.in.th/mdw/easybills_middleware_external/jsonexchange.aspx"
        guard let urlString = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) else{
            return
        }
        
        guard let URL = URL(string:urlString) else {
            
            return
        }
        
        path = URLRequest(url:URL)
        path.httpMethod = method.rawValue
        
        self.method = method
    }
    
}

