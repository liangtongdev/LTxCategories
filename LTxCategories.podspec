Pod::Spec.new do |s|
  s.name         = "LTxCategories"
  s.version      = "0.0.1"
  s.summary      = "收集常用的扩展，方便开发中使用. "
  s.license      = "MIT"
  s.author             = { "liangtong" => "liangtongdev@163.com" }

  s.homepage     = "https://github.com/liangtongdev/LTxCategories"
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/liangtongdev/LTxCategories.git", :tag => "#{s.version}", :submodules => true }

  s.frameworks = "Foundation", "UIKit"

  s.public_header_files = 'LTxCategories/*.h'
  s.source_files = 'LTxCategories/*.{h,m}'

end
