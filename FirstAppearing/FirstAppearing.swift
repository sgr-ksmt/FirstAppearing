//
//  FirstAppearing.swift
//  TestProtocol
//
//  Created by Suguru Kishimoto on 2016/01/29.
//
//

import Foundation
import UIKit


extension UIViewController {
    private struct AssociatedKeys {
        static var viewWillAppearOnceKey = "once_viewWillAppear"
        static var viewDidAppearOnceKey = "once_viewDidAppear"
    }
    
    private func getBookValue(key: UnsafeRawPointer) -> Bool {
        return (objc_getAssociatedObject(self, key) as? Bool) ?? false
    }
    
    private func setBoolValue(key: UnsafeRawPointer, value: AnyObject?) {
        if getBookValue(key: key) { return }
        objc_setAssociatedObject(self, key, value, .OBJC_ASSOCIATION_RETAIN)
    }
    
    internal var alreadyCalledViewWillAppearOnce: Bool {
        get {
            return getBookValue(key: &AssociatedKeys.viewWillAppearOnceKey)
        }
        set {
            setBoolValue(key: &AssociatedKeys.viewWillAppearOnceKey, value: newValue as AnyObject)
        }
    }
    internal var alreadyCalledViewDidAppearOnce: Bool {
        get {
            return getBookValue(key: &AssociatedKeys.viewDidAppearOnceKey)
        }
        set {
            setBoolValue(key: &AssociatedKeys.viewDidAppearOnceKey, value: newValue as AnyObject)
        }
    }
    
}

public protocol FirstAppearing {}
public extension FirstAppearing where Self: UIViewController {
    
    private func callOnce(flag: inout Bool, closure: () -> Void) {
        if !flag {
            closure()
            flag = true
        }
    }
    
    func viewWillAppearOnce(fromFunction: String = #function, closure: () -> Void) {
        guard fromFunction == "viewWillAppear" else {
            return
        }
        callOnce(flag: &alreadyCalledViewWillAppearOnce, closure: closure)
    }
    
    func viewDidAppearOnce(fromFunction: String = #function, closure: () -> Void) {
        guard fromFunction == "viewDidAppear" else {
            return
        }
        callOnce(flag: &alreadyCalledViewDidAppearOnce, closure: closure)
    }
    
}

