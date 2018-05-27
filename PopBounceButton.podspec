Pod::Spec.new do |s|

  s.name         = "PopBounceButton"
  s.version      = "1.0.0"
  s.summary      = "A highly-customizable animated button inspired by the familiar button stack from Tinder."
  s.description  = <<-DESC
A highly-customizable animated button built with Facebook's Pop animation library. Inspired by the familiar button stack from Tinder.
                   DESC
  s.homepage     = "https://github.com/mac-gallagher/PopBounceButton"
  # s.screenshots  = "https://github.com/mac-gallagher/PopBounceButton/tree/master/Screenshots/example.gif", "https://github.com/mac-gallagher/PopBounceButton/tree/master/Screenshots/tinder_demo.gif"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Mac Gallagher" => "jmgallagher36@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/mac-gallagher/PopBounceButton.git", :tag => "1.0.0" }
  s.source_files  = "Sources/**/*"
  s.framework  = "UIKit", "pop"
  s.dependency "pop", "~> 1.0"

end
