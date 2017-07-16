//
//  MapperDateTransform.swift
//  QPER
//
//  Created by Ittipong on 11/21/16.
//  Copyright © 2016 Siamsoftwaresolution. All rights reserved.
//

import ObjectMapper

class MapperDateTransform: DateTransform {
    
    override func transformFromJSON(_ value: Any?) -> Date? {
        
        
        
        if let dateStr = value as? String{
            
            let dateFormat = DateFormatter()
            dateFormat.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
            dateFormat.locale = Locale(identifier: "en_US_POSIX")
            
            
            let list = dateStr.components(separatedBy: ".")
            
            if list.count == 2 {
                
                let  newData = list[safe:0].stringValue
                dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                
                if let date = dateFormat.date(from: newData) {
                    return date
                }
                
                
            }
            let  newData = dateStr
            dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            if let date = dateFormat.date(from: newData) {
                return date
            }
            
            dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            if let date = dateFormat.date(from: dateStr) {
                return date
            }
            
        }
        return nil
        
    }
}
