#
# Be sure to run `pod lib lint CollectionViewLayoutKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CollectionViewLayoutKit'
  s.version          = '0.3.0'
  s.summary          = 'A bundle of various UICollectionViewLayouts.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  This module contains the following collection view layouts:
  - TopLeftLayout
  - WaterfallLayout
                       DESC

  s.homepage         = 'https://github.com/AlanQuarter/CollectionViewLayoutKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'AlanQuarter' => 'the9thstar@naver.com' }
  s.source           = { :git => 'https://github.com/AlanQuarter/CollectionViewLayoutKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CollectionViewLayoutKit/Sources/**/*.swift'
  
  # s.resource_bundles = {
  #   'CollectionViewLayoutKit' => ['CollectionViewLayoutKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

  s.swift_version = '5.0'
end
