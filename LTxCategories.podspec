Pod::Spec.new do |s|
  s.name         = "LTxCategories"
  s.version      = "0.0.7"
  s.summary      = "收集常用的扩展，方便开发中使用. "
  s.license      = "MIT"
  s.author             = { "liangtong" => "liangtongdev@163.com" }

  s.homepage     = "https://github.com/liangtongdev/LTxCategories"
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/liangtongdev/LTxCategories.git", :tag => "#{s.version}", :submodules => true }

  s.frameworks = "Foundation", "UIKit"


  # Common
  s.subspec 'Common' do |cmn|
      cmn.source_files  =  "LTxCategories/Common/*.{h,m}"
      cmn.public_header_files = "LTxCategories/Common/*.h"
  end
  
  # UIKit
  s.subspec 'UIKit' do |kit|
      kit.source_files  =  "LTxCategories/UIKit/*.{h,m}"
      kit.public_header_files = "LTxCategories/UIKit/*.h"
      kit.dependency 'LTxCategories/Common'
  end
  
  # Foundation
  s.subspec 'NSFoundation' do |foundation|
      foundation.source_files  =  "LTxCategories/Foundation/*.{h,m}"
      foundation.public_header_files = "LTxCategories/Foundation/*.h"
      foundation.dependency 'LTxCategories/Common'
  end
  
  # Core
  s.subspec 'Core' do |core|
      core.source_files  =  "LTxCategories/LTxCategories.h"
      core.public_header_files = "LTxCategories/LTxCategories.h"
      core.dependency 'LTxCategories/UIKit'
      core.dependency 'LTxCategories/NSFoundation'
  end
  

  
  
end
