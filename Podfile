platform :ios, '9.0'

inhibit_all_warnings!

source 'https://github.com/CocoaPods/Specs.git'

workspace 'demo.xcworkspace'


def magic_pods()

    pod 'TangramKit', '~> 1.3.2'
    pod 'SnapKit', '~> 4.2.0'
    pod 'ObjectMapper', '~> 3.5.1'
    pod 'SVGAPlayer', '~> 2.5.2'
    pod 'SDWebImage', '~> 5.4.0'

end

target 'magicpager' do
    use_frameworks!
    project 'magicpager/magicpager'
    magic_pods()
end

target 'demo' do
    use_frameworks!
    project 'demo'
    pod 'SDWebImageWebPCoder', '~> 0.2.5'
end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            #config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
            config.build_settings['CLANG_ENABLE_OBJC_WEAK'] ||= 'YES'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
        end
    end
end



