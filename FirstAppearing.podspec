Pod::Spec.new do |s|

  s.name         = "FirstAppearing"
  s.version      = "0.1.0"
  s.summary      = "Helper Protocol-Extension for UIViewController's viewWillAppear/viewDidAppear."

  s.description  = <<-DESC
                    Helper Protocol-Extension for UIViewController's "viewWillAppear/viewDidAppear" Written in Swift.
                   DESC

  s.homepage = "https://github.com/sgr-ksmt/FirstAppearing"

  s.license = "MIT"

  s.author = "Suguru Kishimoto"

  s.platform = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.source = { :git => "https://github.com/sgr-ksmt/FirstAppearing.git", :tag => s.version.to_s }


  s.source_files  = "FirstAppearing/**/*.swift"

  s.requires_arc = true

end
