#
# Be sure to run `pod lib lint Localizer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IDLocalizer'
  s.version          = '0.1.0'
  s.summary          = 'Independent Localizer for VIPER'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'A solution to localize your applications'

  s.homepage         = 'https://BronnikovAndrey@github.com/BronnikovAndrey/IDTouchIDManager'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'BronnikovAndrey' => 'bronnikov@improveitgroup.com' }
  s.source           = { :git => 'https://BronnikovAndrey@github.com/BronnikovAndrey/IDLocalizer.git', :tag => '0.1.0' }

  s.ios.deployment_target = '8.0'
  s.source_files = 'IDLocalizer/Classes/**/*'

end
