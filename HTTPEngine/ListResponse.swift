//
//  ListResponse.swift
//  NITI2.0
//
//  Created by Ittipong on 2/23/17.
//  Copyright © 2017 1.0.0. All rights reserved.
//

import ObjectMapper

class ListResponse<T:NMapper> : NMapper{
    
    var count : Int?
    var next : AnyObject?
    var previous : AnyObject?
    var list : [T]?
    var property : PropertyModel?
    var report : ReportModel?
    var dataModel : DataModel?
    var newsV2Model : NewsV2Model?
    var notifModel : [NotificationModel]?
    var repairV2Model : [RepairV2Model]?
    var dupRoom : UnitModel?
    var searchTenant : [SearchTenantModel]?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map)
    {
        super.mapping(map: map)
        
        count <- map["count"]
        next <- map["next"]
        previous <- map["previous"]
        list <- map["results"]
        property <- map["data"]
        report <- map["data"]
        dataModel <- map["data"]
        newsV2Model <- map["data"]
        notifModel <- map["data"]
        repairV2Model <- map["data"]
        dupRoom <- map["data"]
        searchTenant <- map["data"]
        
    }
    
}

