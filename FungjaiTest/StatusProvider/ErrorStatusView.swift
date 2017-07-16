//
//  ErrorStatusView.swift
//
//  Created by MarioHahn on 25/08/16.
//

import Foundation
import UIKit

//static let errorTag     = 7024
//static let emtyTag      = 7025
//static let noneTag      = 7026
//}

open class ErrorStatusView: UIView, ErrorStatusDisplaying {
    
    
    open var postition: CGRect? {
        didSet{
            guard let bound = postition else { return }
            self.frame = bound
            self.loadingFail.frame = bound
        }
    }
    
    open var retry: (()->Void)? {
        didSet{
            guard let _ = retry else { return }
            
            errorActionButton.isHidden = false
        }
    }
    
    open var error: String? {
        didSet{
            
            guard let error = error else { return }
            
            self.loadingFail.title = error
        }
    }
    
    var loadingFail = LoadingFailView();
    
    let errorTitleLabel: UILabel = {
        
        $0.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        $0.text = "Error"
        
        return $0
    }(UILabel())
    
    let errorDescriptionLabel: UILabel = {
        $0.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption2)
        $0.textColor = UIColor.black
        
        return $0
    }(UILabel())
    
    let errorActionButton: UIButton = {
        $0.setTitle("Retry", for: UIControlState())
        $0.isHidden = true
        
        return $0
    }(UIButton(type: UIButtonType.system))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

 
        self.frame = frame
        
        self.loadingFail.frame = self.bounds
        
        self.addSubview(loadingFail)
        self.loadingFail.reloadHandle = {
            self.retry?()
        }
        
    }
    

    
    open override var tintColor: UIColor!{
        didSet{
            errorTitleLabel.textColor = tintColor
            errorDescriptionLabel.textColor = tintColor
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
