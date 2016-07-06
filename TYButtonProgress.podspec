Pod::Spec.new do |s|

  s.name         = "TYButtonProgress"
  s.version      = "0.0.2"
  s.summary      = "带进度的圆环按钮"
  s.homepage     = "https://github.com/qqcc1388/TYButtonProgress"
  s.license      = 'MIT'

  s.author       = { "tiny" => "843458091@qq.com" }
 
  s.platform     = :ios, '6.0'

  s.source       = { :git => "https://github.com/qqcc1388/TYButtonProgress.git", :tag => "0.0.2" }

  s.source_files  = 'TYButtonProgress/source/*'

  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

end