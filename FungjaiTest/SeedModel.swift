//
//  SeedModel.swift
//  FungjaiTest
//
//  Created by Admin on 7/16/2560 BE.
//  Copyright © 2560 Admin. All rights reserved.
//

import ObjectMapper


enum SeedType {
    
    case none
    case track
    case video
    case ads
    
}

class SeedModel:Mappable {
    
    var id : Int?
    var name : String?
    var cover : String?
    var contentType : SeedType = .none
    
    private var type  : String?
    
    init(){
        
    }
    
    required init?( map: Map){}
    
    func mapping(map: Map)
    {
        
        id <- map["id"]
        name <- map["name"]
        type <- map["type"]
        cover <- map["cover"]
        
        type = type?.lowercased()
        
        if type == "track" {
            contentType = .track
        }else if type == "video" {
            contentType = .video
        }else if type == "ads" {
            contentType = .ads
        }else {
            contentType = .none
        }
    }
    
}
