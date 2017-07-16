//
//  RequestChain.swift
//  NITI2.0
//
//  Created by SiamSoft on 3/1/2560 BE.
//  Copyright © 2560 1.0.0. All rights reserved.
//

import Alamofire

class RequestChain {
    typealias CompletionHandler = (_ success:Bool, _ errorResult:ErrorResult?) -> Void
    
    struct ErrorResult {
        let request:DataRequest?
        let error:Error?
    }
    
    fileprivate var requests:[DataRequest] = []
    
    init(requests:[DataRequest]) {
        self.requests = requests
    }
    
    func start(_ completionHandler:@escaping CompletionHandler) {
        
        if let request = requests.first {
            
            request.validate().response(completionHandler: { (response:DefaultDataResponse) in
                
                if let error = response.error {
                    completionHandler(false, ErrorResult(request: request, error: error))
                    return
                }
                self.requests.removeFirst()
                self.start(completionHandler)
            })
            request.resume()
        }else {
            completionHandler(true, nil)
            return
        }
        
    }
}
