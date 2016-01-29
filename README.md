# FirstAppearing
Helper Protocol-Extension for UIViewController's viewWillAppear/viewDidAppear.

[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/FirstAppearing.svg?style=flat)](http://cocoapods.org/pods/FirstAppearing)
[![License](https://img.shields.io/cocoapods/l/FirstAppearing.svg?style=flat)](http://cocoapods.org/pods/FirstAppearing)
[![Platform](https://img.shields.io/cocoapods/p/FirstAppearing.svg?style=flat)](http://cocoapods.org/pods/FirstAppearing)

## :tada:Features
- Just once do process in *viewWillAppear/viewDidAppear*
- Safety called. (If you use *viewWillAppearOnce* in *viewDidLoad*, this process will not be working.)

## :pencil2:How to use

- Adopt *FirstAppearing* protocol.
- Use *viewWillAppearOnce* in *viewWillAppear* or <br />
Use *viewDidAppearOnce* in *viewDidAppear*.

```swift
class SomeViewController: UIViewControlelr, FirstAppearing {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillAppearOnce() {
            print("Wahahaha!") // not working!!
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
        viewWillAppearOnce() {
            // do something
            print("Once call,",__FUNTION__)
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearOnce() {
            // do something
            print("Once call,",__FUNTION__)
        }
    }
}
```

## Requirements
- iOS 8.0+
- Xcode 7.0+(Swift 2+)

## Installation and Setup

### With Carthage
- Just add the following line to your *Cartfile*:

```ruby
github "sgr-ksmt/FirstAppearing"
```

- Run `carthage update` on Terminal.
- Add the framework as described. Details: [Carthage README](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application)

### With CocoaPods
Just add the following line to your Podfile:

```ruby
pod 'FirstAppearing'
```

- Run `pod install` on Terminal.