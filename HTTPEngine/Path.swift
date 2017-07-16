//
//  Path.swift
//  iCash
//
//  Created by Ittipong on 7/24/16.
//  Copyright © 2016 SiamSoftwareSolution. All rights reserved.
//

import UIKit

let oneSignalAppId = "05f19c1c-415a-47e2-8c29-3c59633c4f8d"

let HostURL = "http://128.199.211.205/"

enum Path: String {
    
    // Pre Login
    case token = "o/token/"
    case resetPassword = "rest-auth/password/reset/"
    case changePassword = "rest-auth/password/change/"
    case register = "api/register/"
    
    case avatar = "api/user/avatar/"
    
    case userCurrent = "api/current_user/"
    case userDetail = "api/user_detail/"
    case findTenantV2 = "v2/api/user"
    
    //Property api
    case propertyByUser = "api/property_by_user/"
    case propertyByUserV2 = "v2/api/user/my-property"
    case property = "api/property/"
    case propertyType = "api/property_type/" //GET POST
    case propertyImage = "api/property_image/"
    //case propertyList = "/api/property_list/"
    //case propertyList = "v2/api/property/properties"
    case propertyList = "v2/api/property/"

    //Unit
    case unit = "api/propertyunit/"
    case unitInfo = "api/propertyunitinfo/"
    case unitInfoToken = "api/propertyunitinfo"
    case unitBedRoomType = "api/property_room_type/"
    case unitBathRoomType = "api/property_bath_type/"
    case unitImage = "api/property_unitinfo_image/"
    case unitByUser = "api/propertyunit_by_user/"
    case unitTenent = "api/unituser/"
    
    //Facility
    case facilitySpecial = "api/property_facility_list/"
   
    //Geo
    case geoProvince = "api/geo_province/"
    case geoDistrict = "api/geo_district_by_province/"
    case geoSubDistrictByDistrict = "api/geo_sub_district_by_district/"
    case geoSubDistrict = "api/geo_sub_district/"
    
    
    //News
    case news = "api/news/"
    case newsV2 = "v2/api/news/"
    case newsComment = "api/news_comment/"
    case newsImage = "api/news_image/"
    case newsAnswerChoice = "api/news_answer_choice/"
    
    //Parcel
    case parcel = "api/parcel/"
    
    case repair = "api/repair/"
    case repairComment = "api/repair_comment/"
    case repairType = "api/repair_type_list/"
    case repairType_V2 = "v2/api/repair-type"
    case repairImage = "api/repair_image/"
    //POST /api/repair_image/
    //repair_type_list
    //repair_comment
    ///api/parcel/?property_id=1&receive_status=0
    
    case unitLease = "api/unit_lease/"
    
    //Report
    case reportCM = "v2/api/report/comments"
    case reportRoom = "v2/api/report/verifies"
    
    //Facebook
    case loginFB = "v2/api/facebook/login"
    
    //Notification
    case getNotification = "v2/api/getNoti"
    case postNotification = "v2/api/notification"
    
    case duplicateRoom = "v2/api/property-unit/"
    
}
