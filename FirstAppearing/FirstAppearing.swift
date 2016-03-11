//
//  FirstAppearing.swift
//  TestProtocol
//
//  Created by Suguru Kishimoto on 2016/01/29.
//
//

import Foundation
import UIKit


private extension UIViewController {
    private struct AssociatedKeys {
        static var viewWillAppearOnceKey = "once_viewWillAppear"
        static var viewDidAppearOnceKey = "once_viewDidAppear"
    }
    
    private func getBookValue(key: UnsafePointer<Void>) -> Bool {
        return (objc_getAssociatedObject(self, key) as? Bool) ?? false
    }
    
    private func setBoolValue(key: UnsafePointer<Void>, value: AnyObject?) {
        if getBookValue(key) { return }
        objc_setAssociatedObject(self, key, value, .OBJC_ASSOCIATION_RETAIN)
    }
    
    private var alreadyCalledViewWillAppearOnce: Bool {
        get {
            return getBookValue(&AssociatedKeys.viewWillAppearOnceKey)
        }
        set {
            setBoolValue(&AssociatedKeys.viewWillAppearOnceKey, value: newValue)
        }
    }
    private var alreadyCalledViewDidAppearOnce: Bool {
        get {
            return getBookValue(&AssociatedKeys.viewDidAppearOnceKey)
        }
        set {
            setBoolValue(&AssociatedKeys.viewDidAppearOnceKey, value: newValue)
        }
    }
    
}

public protocol FirstAppearing {}
public extension FirstAppearing where Self: UIViewController {
    
    private func callOnce(inout flag: Bool, @noescape closure: () -> Void) {
        if !flag {
            closure()
            flag = true
        }
    }
    
    public func viewWillAppearOnce(fromFunction: String = __FUNCTION__, @noescape closure: () -> Void) {
        guard fromFunction == "viewWillAppear" else {
            return
        }
        callOnce(&alreadyCalledViewWillAppearOnce, closure: closure)
    }
    
    public func viewDidAppearOnce(fromFunction: String = __FUNCTION__, @noescape closure: () -> Void) {
        guard fromFunction == "viewDidAppear" else {
            return
        }
        callOnce(&alreadyCalledViewDidAppearOnce, closure: closure)
    }
    
}