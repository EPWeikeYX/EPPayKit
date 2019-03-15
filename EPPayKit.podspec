#
# Be sure to run `pod lib lint EPPayKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'EPPayKit'
    s.version          = '1.0.0'
    s.summary          = 'iOS 微信支付、支付宝支付、银联支付集成'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

    s.homepage         = 'https://blog.jarhom.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { '陈家宏' => '197778537@qq.com' }
#s.source           = { :git => 'https://github.com/陈家宏/EPPayKit.git', :tag => s.version.to_s }
    s.source           = { :git => '~/Project/EPPayKit/', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.requires_arc = true
    s.ios.deployment_target = '8.0'
    
    s.subspec 'Core' do |cs|
        cs.dependency 'EPPayKit/Wechat'
        cs.dependency 'EPPayKit/Alipay'
        cs.dependency 'EPPayKit/UnionPay'
    end
    
    s.subspec 'Wechat' do |ss|
        ss.source_files = 'EPPayKit/Lib/WeChatSDK/*.{h,m}'
        ss.public_header_files = 'EPPayKit/Lib/WeChatSDK/*.h'
        ss.vendored_libraries = 'EPPayKit/Lib/WeChatSDK/libWeChatSDK.a'
        ss.frameworks = 'Security','SystemConfiguration','CoreTelephony'
        ss.libraries = 'z', 'sqlite3.0', 'c++'
        ss.requires_arc = true
    end
    
    s.subspec 'Alipay' do |ss|
        ss.resources = 'EPPayKit/Lib/Alipay/AlipaySDK.bundle'
        #ss.source_files = 'EPPayKit/Lib/Alipay/*.{h,m}'
        #ss.public_header_files = 'EPPayKit/Lib/Alipay/*.h'
        ss.frameworks = 'SystemConfiguration', 'CoreTelephony', 'QuartzCore', 'CoreText', 'CoreGraphics', 'UIKit', 'Foundation', 'CFNetwork', 'CoreMotion'
        ss.vendored_frameworks = 'EPPayKit/Lib/Alipay/AlipaySDK.framework'
        ss.libraries = 'z', 'c++'
        ss.requires_arc = true
    end
    
    s.subspec 'UnionPay' do |ss|
        ss.source_files  = 'EPPayKit/Lib/UnionPay/inc/*.{h,m}'
        ss.public_header_files = 'EPPayKit/Lib/UnionPay/inc/*.h'
        ss.frameworks = 'Foundation', 'UIKit', 'CFNetwork', 'SystemConfiguration'
        ss.vendored_libraries = 'EPPayKit/Lib/UnionPay/libs/libPaymentControl.a'
        ss.libraries = 'z', 'stdc++'
        ss.requires_arc = true
    end
   
end
