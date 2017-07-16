//
//  LoadingStatusView.swift
//  3MobileTV
//
//  Created by MarioHahn on 25/08/16.
//  Copyright © 2016 Hutchison Drei Austria GmbH. All rights reserved.
//

import Foundation
import UIKit

open class LoadingStatusView: UIView {
    
    public enum LoadingStatusStyle {
        case labelWithActivity
        case label
        case activity
    }
    

    var loading = LoadingView();
    var loadingStyle: LoadingStatusStyle = .labelWithActivity{
        didSet{
            
        }
    }
    
    public convenience init(loadingStyle style: LoadingStatusStyle){
        self.init(frame:CGRect.zero)
        
        loadingStyle = style
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        

        self.frame = frame
        
        self.loading.frame = self.bounds
        self.addSubview(loading)
        

    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override var tintColor: UIColor!{
        didSet{
            
        }
    }
}
