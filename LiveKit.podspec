#
# Be sure to run `pod lib lint LiveKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LiveKit'
  s.version          = '0.1.15'
  s.summary          = 'A short description of LiveKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/dony1989/LiveKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sweed7' => 'rralun@163.com' }
  s.source           = { :git => 'https://github.com/dony1989/LiveKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  # s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

  s.ios.deployment_target = '9.0'

  s.source_files = 'LiveKit/Classes/LiveModule/LiveModuleHeader.h'

  s.resource_bundles = {
    'LiveKit' => ['LiveKit/Assets/*']
  }

  s.subspec 'Controller' do |con|
  con.source_files = 'LiveKit/Classes/LiveModule/Controller/*'
  con.frameworks = 'UIKit','Foundation'
  end

  s.subspec 'LiveMeditor' do |meditor|
  meditor.source_files = 'LiveKit/Classes/LiveModule/LiveMeditor/*'
  meditor.frameworks = 'UIKit','Foundation'
  end

  s.subspec 'NetWork' do |net|
  net.source_files = 'LiveKit/Classes/LiveModule/NetWork/*'
  net.frameworks = 'UIKit','Foundation'
  end

  s.subspec 'AppConfigs' do |config|
  config.source_files = 'LiveKit/Classes/LiveModule/Tools/AppConfigs/*'
  config.frameworks = 'UIKit','Foundation'
  end

  s.subspec 'Category' do |category|
  category.source_files = 'LiveKit/Classes/LiveModule/Tools/Category/*'
  category.frameworks = 'UIKit','Foundation'
  end

  s.subspec 'Utility' do |utility|
  utility.source_files = 'LiveKit/Classes/LiveModule/Tools/Utility/*'
  utility.frameworks = 'UIKit','Foundation'
  end
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation', 'UIKit'
  s.dependency 'AFNetworking'
  s.dependency 'HandyFrame'
  s.dependency 'CTMediator'
  s.dependency 'SDWebImage'
  s.dependency 'MJRefresh'
  s.dependency 'MJExtension'
  s.dependency 'Masonry'
  s.dependency 'MBProgressHUD'
  s.dependency 'FLAnimatedImage'
  s.dependency 'AFNetworking'
end
