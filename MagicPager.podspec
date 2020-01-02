#
#  Be sure to run `pod spec lint MagicPager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "MagicPager"
  s.version      = "0.1.0"
  s.summary      = "Just magic"

  s.description  = "magic is good"

  s.homepage     = "https://github.com/SvenFang/MagicPager-IOS"

  s.license      = "magicpager from Sven"
  

  s.author             = { "Sven" => "sven.fang@icloud.com" }
  
  s.ios.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/SvenFang/MagicPager-IOS.git", :tag => "#{s.version}" }


  s.source_files  = "magicpager/magicpager/**/*.{swift}"
  s.requires_arc = true
  s.swift_version = '5.0'
  
  s.dependency 'TangramKit', '~> 1.3.2'
  s.dependency 'SnapKit', '~> 4.2.0'
  s.dependency 'ObjectMapper', '~> 3.5.1'
  s.dependency 'SVGAPlayer', '~> 2.5.2'
  s.dependency 'SDWebImage', '~> 5.4.0'

  s.pod_target_xcconfig = {
    'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS=1',
    'DEFINES_MODULE' => 'YES'
  }
  
end
