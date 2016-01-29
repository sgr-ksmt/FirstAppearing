//
//  FirstAppearing.swift
//  TestProtocol
//
//  Created by Suguru Kishimoto on 2016/01/29.
//
//

import Foundation
import UIKit

private var alreadyCalledViewWillAppearOnceKey: UInt8 = 0
private var alreadyCalledViewDidAppearOnceKey: UInt8 = 0

private extension UIViewController {
    
    private func getBookValue(key: UnsafePointer<UInt8>) -> Bool {
        return (objc_getAssociatedObject(self, key) as? Bool) ?? false
    }
    
    private func setBoolValue(key: UnsafePointer<UInt8>, value: AnyObject?) {
        if getBookValue(key) { return }
        objc_setAssociatedObject(self, key, value, .OBJC_ASSOCIATION_RETAIN)
    }
    
    private var alreadyCalledViewWillAppearOnce: Bool {
        get {
            return getBookValue(&alreadyCalledViewWillAppearOnceKey)
        }
        set {
            setBoolValue(&alreadyCalledViewWillAppearOnceKey, value: newValue)
        }
    }
    private var alreadyCalledViewDidAppearOnce: Bool {
        get {
            return getBookValue(&alreadyCalledViewDidAppearOnceKey)
        }
        set {
            setBoolValue(&alreadyCalledViewDidAppearOnceKey, value: newValue)
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