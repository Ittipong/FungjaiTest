//
//  ErrorExtension.swift
//  MarketingTU
//
//  Created by Ittipong on 8/30/16.
//  Copyright © 2016 Ittipong. All rights reserved.
//

import UIKit

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}

extension Error {
    
    var errorMessage:String{
        
        print(self.code)
        print(self.domain)
        
        var errorMessage:String = ""
        switch code {
        case 500:
            errorMessage = "Internal server error"
        case -1009:
            errorMessage = "The Internet connection appears to be offline."
            
        case -1001:
            errorMessage = "The request timed out please try again."
            
        case -1011:
            errorMessage = "Sassion time out"
        default:
            errorMessage = self.localizedDescription
        }
        
        return errorMessage
    }
    
}
