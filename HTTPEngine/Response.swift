//
//  Response.swift
//  EventApp
//
//  Created by Ittipong on 2/6/17.
//  Copyright © 2017 1.0.0. All rights reserved.
//

import ObjectMapper


class Response <T: Mappable>: Mappable{
    
    var data : T?
    var list : [T]?
    
    var message : String?
    var status : Bool?
    
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        data <- map["data"]
        list <- map["data"]
        list <- map["data"]
        message <- map["message"]
        status <- map["status"]
        
    }
    
}

class Empty: Mappable{
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
    }
}
