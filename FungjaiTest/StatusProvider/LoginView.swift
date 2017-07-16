//
//  LoginView.swift
//  MarketingTU
//
//  Created by Ittipong on 9/29/16.
//  Copyright © 2016 Ittipong. All rights reserved.
//

import UIKit

class LoginView: UIView {

    @IBOutlet private var contentView:UIView?
     @IBOutlet open var btnLogin: UIButton!
    // other outlets
    
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(content)
    }

}
