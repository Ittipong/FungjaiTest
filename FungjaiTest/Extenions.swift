//
//  ViewExtension.swift
//  FungjaiTest
//
//  Created by Admin on 7/16/2560 BE.
//  Copyright © 2560 Admin. All rights reserved.
//



extension UIView: StatusProvider {
    
    public var loadingView: UIView? {
        return LoadingStatusView(frame: self.bounds)
    }
    public var emptyView: UIView?{
        let login = LoginView()
        login.frame = self.bounds
        return login
    }
    
}

extension UIViewController: StatusProvider {
    
    public var loadingView: UIView? {
        return LoadingStatusView(frame: self.view.bounds)
    }
    
    public var emptyView: UIView?{
        let login = LoginView()
        login.frame = self.view.bounds
        return login
    }
    
}

extension Array {
    subscript (safe index:Int?) -> Element? {
        guard let index = index else {
            return nil
        }
        return index < count ? self[index] : nil
    }
}
protocol OptionalString {
    
}
extension String: OptionalString {
    var isNilOrEmpty: Bool {
        return self.isEmpty
    }
    var stringValue:String {
        get {
            return self
        }
    }
}

extension Optional where Wrapped: OptionalString {
    var isNilOrEmpty: Bool {
        return ((self as? String) ?? "").isEmpty
    }
    var stringValue:String {
        
        get {
            if isNilOrEmpty {
                return ""
            }else{
                if let value = self {
                    if let v = value as? String {
                        return v
                    }else {
                        return ""
                    }
                    
                }else{
                    return ""
                }
                
            }
            
        }
    }
}

public extension Sequence {
    func categorise<U : Hashable>(_ key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var dict: [U:[Iterator.Element]] = [:]
        for el in self {
            let key = key(el)
            if case nil = dict[key]?.append(el) { dict[key] = [el] }
        }
        return dict
    }
}
extension Sequence {
    // Using a `typealias` because it's shorter to write `E`
    // Think of it as a shortcut
    typealias E = Iterator.Element
    
    // Declaring a `K` generic that we'll use as the type of the key
    // for the resulting dictionary. The only restriction is having
    // it conforming to the `Hashable` protocol
    func groupBy<K: Hashable>(handler: (E) -> K) -> [K: [E]] {
        // Creating the resulting dictionary
        var grouped = [K: [E]]()
        
        // Iterating over our elements
        self.forEach { item in
            // Retrieving the key based on the current item
            let key = handler(item)
            
            if grouped[key] == nil {
                grouped[key] = []
            }
            grouped[key]?.append(item)
        }
        
        return grouped
    }
}


import KFSwiftImageLoader

extension UIImageView {
    
    
    
    
    
    func loadImage(withUrl url:String?){
        
        guard let urlString = url ,let urlReq = URL(string:urlString) else {
            return
        }
        
        loadImage(url: urlReq, placeholderImage: UIImage(named:"")) { (complate, error) in
            
            
        }
        
    }
    
    
}

public typealias RefreshHandler = (UIRefreshControl) -> Void

public extension UITableView {
    
    func refreshController(action: @escaping RefreshHandler) {
        
        let refreshControl = UIRefreshControl()
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.addSubview(refreshControl)
        refreshControl.ngl_addAction(forControlEvents: UIControlEvents.valueChanged, withCallback: {
            action(refreshControl)
        })
        
    }
    
}
open class ClosureWrapper : NSObject {
    let _callback : (Void) -> Void
    init(callback : @escaping (Void) -> Void) {
        _callback = callback
    }
    
    open func invoke() {
        _callback()
    }
}

var AssociatedClosure: UInt8 = 0

extension UIControl {
    fileprivate func ngl_addAction(forControlEvents events: UIControlEvents, withCallback callback: @escaping (Void) -> Void) {
        let wrapper = ClosureWrapper(callback: callback)
        addTarget(wrapper, action:#selector(ClosureWrapper.invoke), for: events)
        objc_setAssociatedObject(self, &AssociatedClosure, wrapper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}


extension UIColor {
    
    
    public convenience init(r: Float, g: Float, b: Float, a:Float) {
        assert(r >= 0.0 && r <= 255.0, "Invalid red component")
        assert(g >= 0.0 && g <= 255.0, "Invalid green component")
        assert(b >= 0.0 && b <= 255.0, "Invalid blue component")
        assert(a >= 0.0 && a <= 255.0, "Invalid alpha component")
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
    
    public convenience init(r: Float, g: Float, b: Float) {
        self.init(r:r, g: g, b: b, a: 1.0)
    }
    
    public convenience init(hex:Int) {
        
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(r:Float(components.R), g: Float(components.G), b: Float(components.B), a: 1.0)
    }
    
    public class func random() -> UIColor {
        return UIColor(red: randomCGFloat(), green: randomCGFloat(), blue: randomCGFloat(), alpha: 1)
    }
    
    fileprivate class func randomCGFloat() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    var image:UIImage {
        let rect:CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context : CGContext = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(self.cgColor)
        context.fill(rect)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    
    open class var navBar: UIColor {
        return UIColor(r: 91, g: 114, b: 149, a: 1 )
    }
    open class var navFontColor: UIColor {
        return UIColor(r: 255, g: 255, b: 51, a: 1 )
    }
    
}
