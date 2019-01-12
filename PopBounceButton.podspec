Pod::Spec.new do |s|

  s.name         = "PopBounceButton"
  s.version      = "1.2.2"
  s.platform     = :ios, "9.0"
  s.summary      = "A customizable animated button inspired by the familiar button stack from Tinder."

  s.description  = <<-DESC
A customizable animated button built with Facebook's Pop animation library. Inspired by the familiar button stack from Tinder.
                   DESC

  s.homepage     = "https://github.com/mac-gallagher/PopBounceButton"
  s.screenshots  = ["https://raw.githubusercontent.com/mac-gallagher/PopBounceButton/master/Images/example.gif",
                    "https://raw.githubusercontent.com/mac-gallagher/PopBounceButton/master/Images/tinder_demo.gif"]
  s.documentation_url = "https://github.com/mac-gallagher/PopBounceButton/tree/master/README.md"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Mac Gallagher" => "jmgallagher36@gmail.com" }
  s.source       = { :git => "https://github.com/mac-gallagher/PopBounceButton.git", :tag => "v1.2.2" }

  s.swift_version = "4.2"
  s.source_files = "PopBounceButton/Classes/**/*"

  s.dependency "pop", "~> 1.0"

end
