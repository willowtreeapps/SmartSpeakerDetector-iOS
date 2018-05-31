#
# Be sure to run `pod lib lint SmartSpeakerDetector.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SmartSpeakerDetector'
  s.version          = '0.1.0'
  s.summary          = 'Smart Speaker Detector allows to detect smart speakers on local network.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Smart Speaker Detector allows to detect smart speaker devices on local network.
Current version only supoorts Google Home, but Amazon Alexa detection coming soon.
                       DESC

  s.homepage         = 'https://github.com/willowtreeapps/SmartSpeakerDetector-iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'APACHE', :file => 'LICENSE' }
  s.author           = { 'Luke Tomlinson' => 'luke.tomlinson@willowtreeapps.com' }
  s.source           = { :git => 'https://github.com/willowtreeapps/SmartSpeakerDetector-iOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'SmartSpeakerDetector/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SmartSpeakerDetector' => ['SmartSpeakerDetector/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
