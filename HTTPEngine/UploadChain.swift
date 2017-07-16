//
//  UploadChain.swift
//  NITI2.0
//
//  Created by Ittipong on 3/17/17.
//  Copyright © 2017 1.0.0. All rights reserved.
//

import Alamofire

class UploadChain  {
    typealias CompletionHandler = (_ success:Bool, _ errorResult:Error?) -> Void
    
    var bodyRequest:[String:String] = [:]
    var images:[PhotoModel] = []
    fileprivate var url:String = ""
    fileprivate var method:HTTPMethod = .post
    
    var havePhotoUpload:Bool {
        get{
            
            var count = 0
            for photo in self.images {
                if let _ = photo.imageFile {
                    count += 1
                }
            }
            if count > 0 {
                return true
            }else{
                return false
            }
        }
    }
    
    
    
    init(images:[PhotoModel],url:String,method:HTTPMethod = .post) {
        
        
        var uploadPhoto = [PhotoModel]()
        images.forEach { (photo) in
            if let _ = photo.imageFile {
                uploadPhoto.append(photo)
            }
        }
        self.images = uploadPhoto
        self.url = url
        self.method = method
        
    }
    init(images:[NewsImageModel],url:String,method:HTTPMethod = .post) {
        
        
        var uploadPhoto = [PhotoModel]()
        images.forEach { (photo) in
            
            if let file = photo.imageFile {
                let img = PhotoModel()
                img.imageFile = file
                uploadPhoto.append(img)
            }
        }
        self.images = uploadPhoto
        self.url = url
        self.method = method
        
    }
    
    func start(_ completionHandler:@escaping CompletionHandler) {
        
        
        if self.havePhotoUpload == false {
            completionHandler(true, nil)
            return
        }
        
        if let imageObj = images.first {
            
            
            Alamofire.upload(
                multipartFormData: { multipartFormData in

                    
                    if let image = imageObj.imageFile {
                        
                        if let imageData =  UIImageJPEGRepresentation(image,0.1) {
                            multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                        }
                        
                    }else {
                        // URL IMAGE
                    }
                    
                    for (key, value) in self.bodyRequest {
                        if let data = value.data(using: .utf8) {
                            multipartFormData.append(data, withName: key)
                        }
                    }
            },
                //method:.patch
                to: url,
                method:method,
                encodingCompletion: { encodingResult in
                    
                    
                    switch encodingResult {
                        
                    case .success(let upload, _, _):
                        
                        upload.uploadProgress { progress in // main queue by default
                            print("Upload Progress: \(progress.fractionCompleted)")
                        }
                        upload.downloadProgress { progress in // main queue by default
                            print("Download Progress: \(progress.fractionCompleted)")
                        }
                        
                        
                        upload.responseObject(completionHandler: { (response: DataResponse<PhotoModel>) in
                            
                            
                            switch response.result {
                                
                            case .success(let model):
                                
                                if response.validate || model.image != nil {
                                    self.images.removeFirst()
                                    self.start(completionHandler)
                                }else{
                                    let error = NSError(domain: "Upload Fail", code: 0, userInfo: nil)
                                    completionHandler(false,error)
                                    return
                                }
                            case .failure(let error):
                                
                                completionHandler(false,error)
                                return
                            }

                            
                            if let error = response.result.error {
                                completionHandler(false,error)
                                return
                            }
                            
                            
                            
                        })
                        
                    case .failure(let encodingError):
                        print(encodingError)
                        
                        
                        let error = NSError(domain: "Encoding Error", code: 0, userInfo: nil)
                        completionHandler(false,error)
                        return
                    }
            })
            
            
        }else {
            completionHandler(true, nil)
            return
        }
        
    }
}
