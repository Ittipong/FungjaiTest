//
//  EmptyStatusView
//
//  Created by MarioHahn on 25/08/16.
//

import Foundation
import UIKit


open class EmptyStatusView: UIView, EmptyStatusDisplaying {
    
    open var postition: CGRect? {
        didSet{
            guard let bound = postition else { return }
            self.frame = bound
            self.loadingFail.frame = bound
        }
    }
    //  var action: (()->Void)?
    
    open var action: (()->Void)? {
        didSet{
            guard let _ = action else { return }
            
            errorActionButton.isHidden = false
        }
    }
    
    open var error: String? {
        didSet{
            
            // guard let error = error else { return }
            
            //            self.loadingFail.title = error
        }
    }
    
    var loadingFail = LoginView()
    
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
        self.loadingFail.btnLogin.addTarget(self, action: #selector(actionLogin), for: UIControlEvents.touchUpInside)
        
        
        
        
    }
    
    func actionLogin(){
        self.action?()
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
